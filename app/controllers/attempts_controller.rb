class AttemptsController < ApplicationController
  def new
    @attempt = Attempt.new
    prepare_attempt
  end

  def create
    @attempt = current_user.attempts.build(attempt_params)

    @attempt.competition_id = current_competition.id

    if @attempt.valid?
      songs = Song.all
      correct_count = 0
      @attempt.guesses.each do |guess|
        correct_count += 1 if songs.any? { |s| s.user_id == guess.user_id && s.id == guess.song_id }
      end

      @attempt.correct_count = correct_count
    end

    if @attempt.save
      redirect_to new_attempt_url
    else
      prepare_attempt

      render 'new'
    end
  end

  private

  def prepare_attempt
    @users = User.order(:name)
    songs = current_competition.songs.order('random()')

    # Get a list of all attempts (except ones that we recently failed to save because they were invalid)
    prev_attempts = current_user.group_attempts.where(competition_id:current_competition.id).reject { |a| a.new_record? }
    attempt_count = prev_attempts.size

    already_attempted_today = prev_attempts && prev_attempts.any? && prev_attempts.last.created_at.today?
    @disallow_attempt = already_attempted_today
    if already_attempted_today
      first_attempt = current_competition.attempts.order(:created_at).first
      num_guesses_allowed = (Time.zone.today - first_attempt.created_at.to_date).ceil
      @disallow_attempt = attempt_count >= num_guesses_allowed
    end

    # Make a list of all guesses (all songs)
    all_guesses = prev_attempts.to_a.flat_map { |att| att.guesses }

    # Convenient and quick accessors for users and songs by their ids
    user_hash = Hash[@users.map { |u| [u.id, u] }]
    song_hash = Hash[songs.map { |s| [s.id, s] }]
    correct_count = 0

    has_guesses = @attempt.guesses.any?

    songs.each do |song|
      # Only look at songs that current_user didn't submit
      unless song.user_id == current_user.id || (current_user.group_id.present? && current_user.group_id == user_hash[song.user_id].group_id)
        # Build a guess for this song so that fields_for naturally iterates over it
        guess = has_guesses ? @attempt.guesses.find { |g| g.song_id == song.id } : @attempt.guesses.build(song: song)

        prev_guess_names = []

        # Get a list of all previous guesses for this song
        prev_guesses = all_guesses.find_all { |prev_g| prev_g.song_id == guess.song_id }
        prev_guesses.each do |prev_g|

          # Add to the list of names current_user has guessed for this song
          prev_guess_names << user_hash[prev_g.user_id].name

          # If current_user got it right, mark it correct and provide the user for easy access
          song = song_hash[prev_g.song_id]
          if song.user_id == prev_g.user_id
            guess.correct = true
            guess.user = user_hash[prev_g.user_id]
          end
        end

        correct_count += 1 if guess.correct?

        # Make a nice sentence out of the array (eg. "John, Michael, and Sue")
        guess.previously_guessed_names = prev_guess_names.to_sentence
      end
    end

    # Always report how many guesses were right
    if attempt_count > 0
      flash.now[:notice] = "You got #{correct_count} of #{@attempt.guesses.size} right!"
    end
  end

  def attempt_params
    params.require(:attempt)
      .permit(
        guesses_attributes: [:song_id, :user_id]
      )
  end
end
