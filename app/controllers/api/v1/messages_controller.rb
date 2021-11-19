module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_chat

      def index
        messages = @chat.messages
        render json: messages.to_json(only: [:sequential_number]), status: :ok

      end

      def create
        redis_service = RedisService.new()
        messages_count = redis_service.cache_messages_count(@chat, params[:application_token])
        MessageWorker.perform_async(@chat.id, messages_count, message_params[:body])
        render json: { message_number: messages_count, message_body: message_params[:body] }, status: :ok
      end

      def update
        message = @chat.messages.find_by sequential_number: params[:chat_sequential_number]

        if message.update(message_params)
          render json: message.to_json(only: [:sequential_number, :body]), status: :ok
        else
          render json: message.errors, status: :unprocessable_entity
        end
      end

      def search
        messages = Message.search_body(@chat.id, params[:body])
        render json: messages.as_json(only: [:sequential_number, :body]), status: :ok
      end

      private

      def find_chat
        application = Application.find_by token: params[:application_token]
        @chat = application.chats.find_by sequential_number: params[:chat_sequential_number]
      end
      
      def message_params
        params.require(:message).permit(:body)
      end

    end
  end
end