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

    if @attempt.save
      redirect_to new_attempt_url, notice: "You probably got some right!"
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
