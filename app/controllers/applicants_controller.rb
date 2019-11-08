class ApplicantsController < ApplicationController
  def index
    applicants = Applicant.all
    render json: applicants.to_json( 
      :only => [:id, :name, :location],
      # :include => {
      #   :jobs => {:only => [:title, :description, :created_at]}
      # }
    )
  end

  def show
    applicant = Applicant.find_by(id: params[:id])
    render json: applicant.to_json( 
      :only => [:id, :name, :location],
      :include => {
        :jobs => {:only => [:title, :description, :created_at]}
      }
    )
  end
  
  def create
    applicant = Applicant.new(applicant_params)
    if applicant.save
      render json: applicant
    else
      render json: applicant.errors, status: :unprocessable_entity
    end
  end
  
  def update
    applicant = Applicant.find_by(id: params[:id])
    if applicant.update(applicant_params)
    render json: applicant
    else
    render json: applicant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    applicant = Applicant.find_by(id: params[:id])
    applicant.destroy
  end

  private

  def applicant_params
    params.require(:applicant).permit(:name, :location)
  end

end

