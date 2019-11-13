class JobApplicantsController < ApplicationController

  def create 
    jobApplicant = JobApplicant.create(applicant_id: params[:applicant_id], job_id: params[:job_id])
    applicant = Applicant.find_by(id: params[:applicant_id])
    jsonVariable = applicant.to_json( 
          :only => [:id, :name, :location, :usertype],
          :include => {:jobs => {:only => [:title, :description, :created_at], 
          :include => {:employer => {:only => [:name, :location]}}}
          })
          applicant = JSON.parse jsonVariable
        render json: {applicant: applicant}
    # jobs = Job.find_by(applicant: params[:applicant_name])
      # render json: {applicant: applicant, status:"success", :include => {:jobs => {:only => [:title, :description, :created_at], 
      # :include => {:employer => {:only => [:name, :location]}}}
      # }}, status: :created

  end
end

