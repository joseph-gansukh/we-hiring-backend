class ApplicantsController < ApplicationController
  def index
    applicants = Applicant.all
    render json: applicants.to_json( 
      :only => [:id, :name, :location, :usertype],
      # :include => {
      #   :jobs => {:only => [:title, :description, :created_at]}
      # }
    )
  end

  def show
    applicant = Applicant.find_by(name: params[:name])
    render json: applicant.to_json( 
      :only => [:id, :name, :location, :usertype],
      :include => {:jobs => {:only => [:title, :description, :created_at], 
      :include => {:employer => {:only => [:name, :location, :usertype]}}}}
    )

  end
  
  def create
    applicant = Applicant.create(applicant_params)
    if applicant.valid?
      token = encode_token(applicant_id: applicant.id)
      render json: {applicant: applicant, jwt: token, usertype: applicant.usertype}, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
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
    params.require(:applicant).permit(:name, :location, :password, :usertype)
  end

end

