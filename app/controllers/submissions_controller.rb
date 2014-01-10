class SubmissionsController < ApplicationController

  def new
    @submission = Submission.new
  end

  def create
    sub = current_user.submissions.build(submission_params)
    if sub.save
      redirect_to root_url, :notice => "Submission added!"
    else
      render "new"
    end
  end

  private

  def submission_params
    params.require(:submission)
      .permit(
        :song,
        :artist,
      )
  end
end
