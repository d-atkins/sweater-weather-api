require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  before(:each) do
    create(:user)
  end

  it "sends user's api key if credentials are good" do
    login_info = {email: 'factory.bot.user@example.com', password: 'burgers'}
    post '/api/v1/sessions',
      params: login_info.to_json,
      headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

    user = User.last

    expect(parsed_response[:type]).to eq('users')
    expect(parsed_response[:id]).to eq(user.id.to_s)
    expect(parsed_response[:attributes][:email]).to eq('factory.bot.user@example.com')
    expect(parsed_response[:attributes][:api_key]).to eq(user.api_key)
  end

  describe 'fails with a 401' do
    it 'if email is missing' do
      login_info = {password: 'burgers'}
      post '/api/v1/sessions',
        params: login_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(parsed_response[:Status]).to eq(401)
      expect(parsed_response[:Error]).to eq("Credentials are bad")
    end

    it 'if password is missing' do
      login_info = {email: 'factory.bot.user@example.com'}
      post '/api/v1/sessions',
        params: login_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(parsed_response[:Status]).to eq(401)
      expect(parsed_response[:Error]).to eq("Credentials are bad")
    end

    it 'if password is wrong' do
      login_info = {email: 'factory.bot.user@example.com', password: 'fries'}
      post '/api/v1/sessions',
        params: login_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(parsed_response[:Status]).to eq(401)
      expect(parsed_response[:Error]).to eq("Credentials are bad")
    end

    it 'if email is wrong' do
      login_info = {email: 'factorybot.user@example.com', password: 'burgers'}
      post '/api/v1/sessions',
        params: login_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(parsed_response[:Status]).to eq(401)
      expect(parsed_response[:Error]).to eq("Credentials are bad")
    end
  end
end
