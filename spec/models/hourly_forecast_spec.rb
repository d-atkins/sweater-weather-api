require 'rails_helper'

RSpec.describe HourlyForecast do
  before(:each) do
    json_response = File.read('./spec/fixtures/weather_response.json')
    weather_data = JSON.parse(json_response, symbolize_names: true)
    @hour_forecast = HourlyForecast.new(weather_data[:hourly].first)
  end

  describe 'attributes' do
    it 'has weather forecast info' do
      expect(@hour_forecast.unix_time).to eq(1587322800)
      expect(@hour_forecast.weather.first[:main]).to eq('Clear')
      expect(@hour_forecast.weather.first[:description]).to eq('clear sky')
      expect(@hour_forecast.weather.first[:icon]).to eq('01d')
      expect(@hour_forecast.temp).to eq(54)
    end
  end
end
