class JobsController < ApplicationController

    def index
        jobs = Job.all
        render json: jobs.to_json(
            :except => [:updated_at, :employer_id],
            :include => [{:employer => {:only => [:id, :name, :location, :field]}},
            # {:applicants => {:only => [:name, :location]}}
          ]
        )
    end

    def show
      job = Job.find_by(id: params[:id])
      render json: job.to_json(
        :except => [:updated_at, :employer_id],
        :include => [{:employer => {:only => [:id, :name, :location, :field]}},
        {:applicants => {:only => [:name, :location]}}]
    )
    end
    
    def create

      p 'xxxxxxxxxxxxxxxxxxxx'
      p job_params
      job = Job.new(job_params)
      if job.save
        render json: job
      else
        render json: job.errors, status: :unprocessable_entity
      end
    end

    private
    
    def job_params
      params.require(:job).permit(:title, :field, :description, :employer_id)
    end

end
