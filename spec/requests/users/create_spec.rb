require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  before(:each) do
    create(:user)
  end

  it 'creates new user' do
    registration_info = {email: 'unagi@example.com', password: 'burgers', password_confirmation: 'burgers'}
    post '/api/v1/users',
      params: registration_info.to_json,
      headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


    expect(response).to be_successful
    expect(response.status).to eq(201)

    parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

    user = User.last

    expect(parsed_response[:type]).to eq('users')
    expect(parsed_response[:id]).to eq(1)
    expect(parsed_response[:attributes][:email]).to eq('unagi@example.com')
    expect(parsed_response[:attributes][:api_key]).to eq(user.api_key)

    expect(user.api_key).to be_instance_of(String)
    expect(user.api_key).to_not be_empty
    expect(user.email).to eq('unagi@example.com')
    expect(user.password_digest).to be_instance_of(String)
    expect(user.password_digest).to_not be_empty
  end

  describe 'fails with a 400' do
    it 'if email is missing' do
      registration_info = {password: 'burgers', password_confirmation: 'burgers'}
      post '/api/v1/users',
        params: registration_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(parsed_response[:Status]).to eq(400)
      expect(parsed_response[:Error]).to eq("Email can't be blank")

      user = User.last

      expect(user.email).to eq('factory.bot.user@example.com')
    end

    it 'if password is missing' do
      registration_info = {email: 'unagi@example.com', password_confirmation: 'burgers'}
      post '/api/v1/users',
        params: registration_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(parsed_response[:Status]).to eq(400)
      expect(parsed_response[:Error]).to eq("Password can't be blank")

      user = User.last

      expect(user.email).to eq('factory.bot.user@example.com')
    end

    it 'if password confirmation is missing' do
      registration_info = {email: 'unagi@example.com', password: 'burgers'}
      post '/api/v1/users',
        params: registration_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(parsed_response[:Status]).to eq(400)
      expect(parsed_response[:Error]).to eq("Password confirmation can't be blank")

      user = User.last

      expect(user.email).to eq('factory.bot.user@example.com')
    end

    it "if passwords don't match" do
      registration_info = {email: 'unagi@example.com', password: 'burgers', password_confirmation: 'fries'}
      post '/api/v1/users',
        params: registration_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}


      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(parsed_response[:Status]).to eq(400)
      expect(parsed_response[:Error]).to eq("Password confirmation doesn't match password")

      user = User.last

      expect(user.email).to eq('factory.bot.user@example.com')
    end

    it "if email is already taken" do
      registration_info = {email: 'factory.bot.user@example.com', password: 'burgers', password_confirmation: 'burgers'}
      post '/api/v1/users',
        params: registration_info.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(parsed_response[:Status]).to eq(400)
      expect(parsed_response[:Error]).to eq("Email has already been taken")

      expect(User.all.count).to eq(1)
    end
  end
end
