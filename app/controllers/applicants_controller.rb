class ApplicantsController < ApplicationController
  def index
    applicants = Applicant.all
    render json: applicants.to_json( 
      :only => [:id, :name, :location],
      :include => {
        :jobs => {:only => [:title, :description, :created_at]}
      }
    )
  end
end


