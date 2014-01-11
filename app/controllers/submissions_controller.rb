class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:edit, :update, :destroy]

  def index
    @submissions = current_user.submissions
  end

  def new
    @submission = Submission.new
  end

  def edit
  end

  def create
    sub = current_user.submissions.build(submission_params)
    if sub.save
      redirect_to root_url, :notice => "Submission added!"
    else
      render "new"
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to submissions_url, notice: 'Submission was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @submission.destroy
    redirect_to submissions_url
  end


  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission)
      .permit(
        :song,
        :artist,
      )
  end
end
