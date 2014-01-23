class AttemptsController < ApplicationController
  def new
    @songs = Song.all
    @users = User.all

    @guess = Guess.new
    @attempt = Attempt.new
  end

  def create
  end
end
