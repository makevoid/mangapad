class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end
  
  def create
    @submission = Submission.new(params[:submission])
    Notifier.deliver_submission_notification(@submission)
    redirect_to root_path, notice: "Submission for '#{@submission.name}' sent successfully!"
  end
end