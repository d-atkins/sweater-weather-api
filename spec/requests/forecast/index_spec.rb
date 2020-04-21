require 'rails_helper'

RSpec.describe 'Forecast API', type: :request do
  it 'sends forecast info' do
    weather_data = File.read('./spec/fixtures/weather_response.json')
    weather_response = double("response", status: 200, body: weather_data)
    geocode_data = File.read('./spec/fixtures/geocode_response.json')
    geocode_response = double("response", status: 200, body: geocode_data)

    allow_any_instance_of(Faraday::Connection).to receive(:get).with('/maps/api/geocode/json').and_return(geocode_response)
    allow_any_instance_of(Faraday::Connection).to receive(:get).with('/data/2.5/onecall').and_return(weather_response)

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast_info = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(forecast_info[:current][:temp]).to eq(54)
    expect(forecast_info[:current][:feels_like]).to eq(50)
    expect(forecast_info[:current][:humidity]).to eq(61)
    expect(forecast_info[:current][:visibility]).to eq(10)
    expect(forecast_info[:current][:uvi]).to eq(7.24)
    expect(forecast_info[:current][:current_time]).to eq('1:52 PM, April 19')
    expect(forecast_info[:hourly].count).to eq(8)
    expect(forecast_info[:daily].count).to eq(8)
  end
end
