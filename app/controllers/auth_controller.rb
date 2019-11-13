class AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create] 
  def create
    if params[:auth][:usertype] == "applicant"
      applicant = Applicant.find_by(name: params[:name])
      #User#authenticate comes from BCrypt
      if applicant && applicant.authenticate(params[:password])
        # encode token comes from ApplicationController
        token = JWT.encode({ applicant_id: applicant.id, usertype: 'applicant' }, 'app_secret', 'HS256')
        jsonVariable = applicant.to_json( 
          :only => [:id, :name, :location, :usertype],
          :include => {:jobs => {:only => [:title, :description, :created_at], 
          :include => {:employer => {:only => [:name, :location]}}}
          })
          foo = JSON.parse jsonVariable
        render json: {banana: foo, token: token}
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    
    elsif params[:auth][:usertype] == "employer"
      employer = Employer.find_by(name: params[:name])
      if employer && employer.authenticate(params[:password])
        token = JWT.encode({employer_id: employer.id, usertype: 'employer'}, 'app_secret', 'HS256')
        jsonVariable = employer.to_json( 
              :only => [:id, :name, :location, :field, :usertype],
              :include => {:jobs => {:only => [:title, :description, :created_at], :include => {:applicants => {:only => [:name, :location]}}}}
            )
        employerData = JSON.parse jsonVariable
        render json: {employer: employerData, token: token}
      else
        render json: {message: 'Invalid username or password'}, status: :unauthorized
      end
    end
  end

  def show
    jwt_token = request.headers[:Authorization]
    decode_token = JWT.decode(jwt_token, 'app_secret', true, algorithm: 'HS256')
    user_type = decode_token[0]['usertype']
    if user_type == 'applicant'
      id = decode_token[0]['id']
      applicant = Applicant.find(id)
      output = { name: applicant.name, user_type: 'applicant', id: applicant.id, token: jwt_token }
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
