class AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create] 
  def create
    p 'PARAMS IN AUTH CONTROLLER IF STATEMENT'
    p params[:auth][:userType]
    if params[:auth][:userType] == "applicant"
      applicant = Applicant.find_by(name: params[:name])
      #User#authenticate comes from BCrypt
      if applicant && applicant.authenticate(params[:password])
        # encode token comes from ApplicationController
        token = JWT.encode({ applicant_id: applicant.id, userType: 'applicant' }, 'app_secret', 'HS256')
        p "TOKEN"
        p token
        jsonVariable = applicant.to_json( 
          :only => [:id, :name, :location],
          :include => {
            :jobs => {
              :only => [:title, :description, :created_at], 
              :include => {
                :employer => {
                  :only => [:name, :location]
                }
              }
            },
          }
          )
          foo = JSON.parse jsonVariable
        render json: {banana: foo, token: token}
        p 'finished sending banana'
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    end
  end

  def show
    jwt_token = request.headers[:Authorization]
    decode_token = JWT.decode(jwt_token, 'app_secret', true, algorithm: 'HS256')
    user_type = decode_token[0]['userType']
    if user_type == 'applicant'
      id = decode_token[0]['id']
      applicant = Applicant.find(id)
      output = { name: applicant.name, user_type: 'applicant', id: applicant.id, email: applicant.email, token: jwt_token }
      if applicant
        render json: output
      else
        render json: { error: 'Not Authorized' }, status: 401
      end
    elsif user_type == 'employer'
      id = decode_token[0]['id']
      employer = Employer.find(id)
      output = { name: employer.name, user_type: 'employer', id: employer.id, token: jwt_token }
      if employer
        render json: output
      else
        render json: { error: 'Not Authorized' }, status: 401
      end
    end
  end
end
