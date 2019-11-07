class EmployersController < ApplicationController
  def index
    employer = Employer.all 
    render json: employer.to_json( 
      :include => {
      :jobs => {:only => [:title, :description, :created_at], 
      :include => {
      :applicants => {:only => [:name, :location]}}},
      }
    )
  end
end
