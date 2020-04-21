require 'rails_helper'

RSpec.describe 'Road Trip API', type: :request do
  before(:each) do
    create(:user)
  end

  it 'sends road trip info to authenticated user', :vcr do
    road_trip_params = {origin: 'Denver,CO', destination: 'Pueblo,CO', api_key: '123'}

    post '/api/v1/road_trip',
      params: road_trip_params.to_json,
      headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}

    road_trip_info = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response).to be_successful

    expect(road_trip_info[:origin]).to eq('Denver,CO')
    expect(road_trip_info[:destination]).to eq('Pueblo,CO')
    expect(road_trip_info[:travel_time]).to be_instance_of(String)
    expect(road_trip_info[:travel_time]).to_not be_empty
    expect(road_trip_info[:arrival_forecast][:temp]).to be_instance_of(Integer)
    expect(road_trip_info[:arrival_forecast][:weather].first[:description]).to be_instance_of(String)
    expect(road_trip_info[:arrival_forecast][:weather].first[:description]).to_not be_empty
  end

  it 'switches to daily forecast for very long road trips', :vcr do
    road_trip_params = {origin: 'Anchorage,AL', destination: 'Tampa,FL', api_key: '123'}

    post '/api/v1/road_trip',
      params: road_trip_params.to_json,
      headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}

    road_trip_info = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response).to be_successful

    expect(road_trip_info[:origin]).to eq('Anchorage,AL')
    expect(road_trip_info[:destination]).to eq('Tampa,FL')
    expect(road_trip_info[:travel_time]).to be_instance_of(String)
    expect(road_trip_info[:travel_time]).to_not be_empty
    expect(road_trip_info[:arrival_forecast][:day]).to be_instance_of(String)
    expect(road_trip_info[:arrival_forecast][:day]).to_not be_empty
    expect(road_trip_info[:arrival_forecast][:temp]).to be_nil
    expect(road_trip_info[:arrival_forecast][:weather].first[:description]).to be_instance_of(String)
    expect(road_trip_info[:arrival_forecast][:weather].first[:description]).to_not be_empty
  end

  describe 'fails with a 401' do
    it 'if API key is missing', :vcr do
      road_trip_params = {origin: 'Denver,CO', destination: 'Pueblo,CO'}

      post '/api/v1/road_trip',
        params: road_trip_params.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(parsed_response[:Status]).to eq(401)
      expect(parsed_response[:Error]).to eq('Unauthorized')
    end

    it 'if API key is invalid', :vcr do
      road_trip_params = {origin: 'Denver,CO', destination: 'Pueblo,CO', api_key: '124'}

      post '/api/v1/road_trip',
        params: road_trip_params.to_json,
        headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(parsed_response[:Status]).to eq(401)
      expect(parsed_response[:Error]).to eq('Unauthorized')
    end
  end
end
