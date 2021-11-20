require 'rails_helper'

RSpec.describe 'Chats API' , type: :request do

  describe 'List messages per chat - Get /api/v1/applications/:application_token/chats/:chat_sequential_number/messages' do
    describe "Get /api/v1/applications/:application_token/chats/:chat_sequential_number/messages" do

      let!(:application)  { FactoryBot.create(:application) }
      let!(:chat) { FactoryBot.create(:chat, application: application) }
      let!(:message) { FactoryBot.create_list(:message, 1, chat: chat) }

      it 'Get all messages per chat' do
          get "/api/v1/applications/#{application.token}/chats/#{chat.sequential_number}/messages"
          json = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(json.size).to eq(1)
          expect(json[0]['sequential_number']).not_to eq(nil)
          expect(json[0]['sequential_number']).to be > 0
      end
    end
  end

  describe 'Send messages per chat - POST /api/v1/applications/:application_token/chats/:chat_sequential_number/messages' do
    describe "POST /api/v1/applications/:application_token/chats/:chat_sequential_number/messages" do

      let!(:application)  { FactoryBot.create(:application) }
      let!(:chat) { FactoryBot.create(:chat, application: application) }

      it 'Create message' do
        message_body = Faker::Lorem.word
        post "/api/v1/applications/#{application.token}/chats/#{chat.sequential_number}/messages", params: {message: {body: message_body}}
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json['message_number']).not_to eq(nil)
        expect(json['message_number']).to be > 0
        expect(json['message_body']).to eq(message_body)
      end
    end
  end
end