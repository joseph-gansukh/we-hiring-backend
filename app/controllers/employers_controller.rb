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
    render json: employer.to_json( 
      :only => [:id, :name, :location, :field],
      :include => {:jobs => {:only => [:title, :description, :created_at], :include => {:applicants => {:only => [:name, :location]}}}}
    )
  end

  def create
    employer = Employer.create(employer_params)
    if employer.valid?
      token = encode_token(employer_id: employer.id)
      render json: {employer: employer, jwt: token}, status: :created
    else
      render json: { error: 'failed to create employer' }, status: :not_acceptable
    end
  end

  private

  def employer_params 
    params.require(:employer).permit(:name, :password, :field, :location)
  end
  
end


