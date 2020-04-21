require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  it 'creates new user' do
    registration_info = {email: 'unagi@example.com', password: 'burgers', password_confirmation: 'burgers'}
    post '/api/v1/users',
      params: registration_info.to_json,
      headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}

    user = User.last

    expect(response).to be_successful

    expect(user.api_key).to be_instance_of(String)
    expect(user.api_key).to_not be_empty
    expect(user.email).to eq('unagi@example.com')
    expect(user.password_digest).to be_instance_of(String)
    expect(user.password_digest).to_not be_empty
  end
end
