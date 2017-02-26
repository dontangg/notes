class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:edit, :update, :destroy]

  def index
    @competitions = Competition.all.order(:created_at)

    unless current_user.admin?
      @competitions = @competitions.where(phase: 2)
    end
  end

  def new
    @competition = Competition.new
  end

  def edit
  end

  def create
    competition = Competition.new(competition_params)

    if competition.save
      redirect_to competitions_url, notice: "competition added!"
    else
      render "new"
    end
  end

  def update
    @competition.update_attributes(competition_params)

    if @competition.save
      redirect_to competitions_url, notice: 'competition was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @competition.destroy
    redirect_to competitions_url
  end

  private

  def set_competition
    @competition = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition)
      .permit(
        :name,
        :active,
        :phase,
      )
  end
end
