class HomeController < ApplicationController
  def index
    unless current_competition
      redirect_to competitions_url and return
    end
    redirect_to current_competition.submitting? ? songs_url : scorecard_url
  end
end
