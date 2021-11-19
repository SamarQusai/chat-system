module Api
  module V1
    class ApplicationsController < ApplicationController
      def index
        applications = Application.order('created_at DESC')
        render json: applications.to_json(only: [:name, :token]), status: :ok
      end

      def create
        application = Application.new(application_params)

        if application.save
          render json: application.to_json(only: [:name, :token]), status: :ok
        else
          render json: application.errors, status: :unprocessable_entity
        end
      end

      def update
        application = Application.find_by token: params[:token]

        if application.update(application_params)
          render json: application.to_json(only: [:name, :token]), status: :ok
        else
          render json: application.errors, status: :unprocessable_entity
        end
      end

      private

      # Define allowed parameters.
      def application_params
        params.require(:application).permit(:name)
      end

    end
  end
end
