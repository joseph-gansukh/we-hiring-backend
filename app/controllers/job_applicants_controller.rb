class JobApplicantsController < ApplicationController

  def create 
    jobApplicant = JobApplicant.create(applicant_id: params[:applicant_id], job_id: params[:job_id])

      render json: {status:"success"}, status: :created

  end
end

