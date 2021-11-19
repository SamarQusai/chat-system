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

end