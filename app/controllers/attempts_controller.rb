class AttemptsController < ApplicationController
  def new
    @songs = Song.all
    @users = User.all

    @attempt = Attempt.new

    @songs.each do |song|
      @attempt.guesses.build(song: song)
    end
  end

  def create
    @attempt = Attempt.new(attempt_params)

    if @attempt.valid?
      songs = Song.all
      correct_count = 0
      @attempt.guesses.each do |guess|
        correct_count += 1 if songs.any? {|s| s.user_id == guess.user_id && s.id && guess.song_id }
      end

      @attempt.correct_count = correct_count
    end

    if @attempt.save
      redirect_to new_attempt_url, notice: "You got #{@attempt.correct_count} right!"
    else
      @users = User.all

      render 'new'
    end
  end

  private

  def attempt_params
    params.require(:attempt)
      .permit(
        guesses_attributes: [:song_id, :user_id]
      )
  end
end
