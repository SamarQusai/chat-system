require 'rails_helper'

describe 'Applications API' , type: :request do
  describe 'List Applications - Get /api/applications' do
    FactoryBot.create_list(:application, 4)

    it 'should return all applications'  do
      get '/api/v1/applications'

      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.size).to eq(4)
      json.each { |x| expect(x['token']).not_to eq(nil) }
    end
  end

  describe 'Creat Application - POST /api/applications' do

    it 'should create an application' do
      name = Faker::Name.name
      post '/api/v1/applications', params: { application: { name: name } }

      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.size).to eq(2)
      expect(json['token']).not_to eq(nil)
      expect(json['name']).to eq(name)
    end

    describe 'Update Application name - PUT /api/applications/token' do

      it 'should update an application name' do
        #Create an application
        name = Faker::Name.name
        post '/api/v1/applications', params: { application: { name: name } }
        application = JSON.parse(response.body)
        token = application['token']

        #Update name of created application by token
        updated_name = Faker::Name.name
        put "/api/v1/applications/#{token}#", params: {application: {name: updated_name}}
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json.size).to eq(2)
        expect(json['token']).to eq(token)
        expect(json['name']).to eq(updated_name)
      end
    end

    describe 'Invalid parameters' do
      it 'should return an error because of missing required parameter' do

        #Create an application
        post '/api/v1/applications', params: {application: {the_name: 'test'}}
        json = JSON.parse(response.body)
        expect(response.status).to eq(422)
        expect(json).to eq({"name"=>["can't be blank"]})
      end
    end

  end
end