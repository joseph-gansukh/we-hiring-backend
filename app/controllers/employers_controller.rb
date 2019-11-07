class EmployersController < ApplicationController
  def index
    employer = Employer.all 
    render json: employer.to_json( 
      :only => [:id, :name, :location, :field],
      :include => {:jobs => {:only => [:title, :description, :created_at], :include => {:applicants => {:only => [:name, :location]}}}}
    )
  end
end
