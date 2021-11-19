require 'rails_helper'

RSpec.describe 'Chats API' , type: :request do

  describe 'List chats per app - Get /api/v1/applications/:application_token/chats' do
    describe "Get /api/v1/applications/:application_token/chats" do
      let!(:application)  { FactoryBot.create(:application) }
      let!(:chat)  { FactoryBot.create_list(:chat, 1, application: application) }

      it 'Get all chats per application' do
        get "/api/v1/applications/#{application.token}/chats"
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json.size).to eq(1)
        expect(json[0]['sequential_number']).not_to eq(nil)
        expect(json[0]['sequential_number']).to be > 0
      end
    end
  end

  describe "Create chat - POST /api/v1/applications/:application_token/chats" do
    let!(:application) { FactoryBot.create(:application) }

    it 'should create a new chat' do
      post "/api/v1/applications/#{application.token}/chats"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['chat_number']).not_to eq(nil)
      expect(json['chat_number']).to be > 0
    end
  end

end