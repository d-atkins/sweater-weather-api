require 'rails_helper'

RSpec.describe 'Backgrounds API', type: :request do
  it 'sends background image info' do
    background_data = File.read('./spec/fixtures/background_response.json')
    background_response = double("response", status: 200, body: background_data)

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(background_response)

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    background_info = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(background_info[:url_l]).to_not be_empty
    expect(background_info[:url_l]).to be_instance_of(String)
    expect(background_info[:title]).to_not be_empty
    expect(background_info[:title]).to be_instance_of(String)
  end
end
