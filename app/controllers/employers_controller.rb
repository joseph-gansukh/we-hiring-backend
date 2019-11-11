class EmployersController < ApplicationController
  def index
    employers = Employer.all 
    render json: employers.to_json( 
      :only => [:id, :name, :location, :field],
      # :include => {:jobs => {:only => [:title, :description, :created_at], :include => {:applicants => {:only => [:name, :location]}}}}
    )
  end

  def show
    employer = Employer.find_by(name: params[:name])
    p employer.id
    render json: employer.to_json( 
      :only => [:id, :name, :location, :field],
      :include => {:jobs => {:only => [:title, :description, :created_at], :include => {:applicants => {:only => [:name, :location]}}}}
    )
  end


end

employer_find_by(name: employer_params)
