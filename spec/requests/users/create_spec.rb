require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  it 'creates new user' do
    registration_info = {email: 'unagi@example.com', password: 'burgers', password_confirmation: 'burgers'}
    post '/api/v1/users?location=denver,co', params: registration_info
    require "pry"; binding.pry
    expect(response).to be_successful
  end
end
