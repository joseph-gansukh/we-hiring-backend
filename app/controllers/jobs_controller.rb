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
    

end
