class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Auto-sign-in the user unless the user is already signed in
      # (eg. creating an account for someone else)
      session[:user_id] = @user.id unless current_user

      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def scorecard
    @competition = params[:competition_id].present? ? Competition.find(params[:competition_id]) : current_competition

    users = User.order(:group_id, :name).includes(:songs)

    # Kyle (id 14) started in competition 9 and Deanna's (id 12) last was competition 8
    if @competition.id < 9
      users = users.where('id < 14')
    else
      users = users.where.not(id: 12)
    end
    
    group_user_ids = current_user.group_id.nil? ? [current_user.id] : User.where(group_id: current_user.group_id).pluck(:id)

    songs = @competition.songs
    @song_count = songs.where.not(user_id: group_user_ids).count

    @show_song_names = !@competition.active?

    @groups = []
    groups_tmp = {} # temporary variable to make it easier to add people to groups
    users.each do |user|
      if user.group_id.nil?
        attempts = user.attempts.where(competition_id:@competition.id).includes(:guesses)
        add_correctly_guessed_names(attempts, users, songs)
        @groups << { users: [user], attempts: attempts }
      else
        group = groups_tmp[user.group_id]
        if group.nil?
          attempts = user.group_attempts.where(competition_id:@competition.id).includes(:guesses)
          add_correctly_guessed_names(attempts, users, songs)
          group = { users: [], attempts: attempts }
          @groups << group
          groups_tmp[user.group_id] = group
        end
        group[:users] << user
      end
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
  end

  def add_correctly_guessed_names(attempts, users, songs)
    attempts.each do |attempt|

      attempt.correctly_guessed_names = ""

      attempt.guesses.each do |guess|

        song = songs.find {|song| song.id == guess.song_id }

        if song.user_id == guess.user_id
          user = users.find {|user| song.user_id == user.id }
          attempt.correctly_guessed_names += ", " unless attempt.correctly_guessed_names.empty?
          attempt.correctly_guessed_names += user.name
        end

      end

      attempt.correctly_guessed_names = "none" if attempt.correctly_guessed_names.empty?
    end
  end
end
