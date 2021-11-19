module Api
  module V1
    class ChatsController < ApplicationController
      before_action :find_application
      
      def index
        chats = @application.chats
        render json: chats.to_json(only: [:sequential_number]), status: :ok
      end
      
      def create
        redis_service = RedisService.new()
        chats_count = redis_service.cache_chats_count(@application)

        ChatWorker.perform_async(@application.token, chats_count)
        render json: { chat_number: chats_count }, status: :ok
      end
      
      private 
      
      def find_application
        @application = Application.find_by token: params[:application_token]
      end
    end
  end
end