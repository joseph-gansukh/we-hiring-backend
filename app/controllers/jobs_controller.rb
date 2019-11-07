class JobsController < ApplicationController

    def index
        job = Job.all
        render json: job.to_json(
            :except => [:updated_at, :employer_id],
            :include => [{:employer => {:only => [:id, :name, :location, :field]}},
            {:applicants => {:only => [:name, :location]}}]
        )
    end

end
