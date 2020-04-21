require 'rails_helper'

RSpec.describe 'Backgrounds API', type: :request do
  it 'sends background image info', :vcr do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    background_info = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(background_info[:url_l]).to_not be_empty
    expect(background_info[:url_l]).to be_instance_of(String)
    expect(background_info[:url_o]).to_not be_empty
    expect(background_info[:url_o]).to be_instance_of(String)
    expect(background_info[:title]).to_not be_empty
    expect(background_info[:title]).to be_instance_of(String)
  end
end
