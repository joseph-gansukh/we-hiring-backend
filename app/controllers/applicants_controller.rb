class ApplicantsController < ApplicationController
  def index
    applicants = Applicant.all
    render json: applicants
  end
  
end
