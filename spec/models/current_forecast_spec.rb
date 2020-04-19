require 'rails_helper'

RSpec.describe CurrentForecast do
  before(:each) do
    json_response = File.read('./spec/fixtures/weather_response.json')
    weather_data = JSON.parse(json_response, symbolize_names: true)
    @current_forecast = CurrentForecast.new(weather_data, 'Denver, CO, USA')
  end

  describe 'attributes' do
    it 'has weather forecast info' do
      expect(@current_forecast.location).to eq('Denver, CO, USA')
      expect(@current_forecast.unix_time).to eq(1587325934)
      expect(@current_forecast.main).to eq('Clear')
      expect(@current_forecast.description).to eq('clear sky')
      expect(@current_forecast.icon).to eq('01d')
      expect(@current_forecast.temp).to eq(54)
      expect(@current_forecast.high).to eq(59)
      expect(@current_forecast.low).to eq(50)
      expect(@current_forecast.feels_like).to eq(50)
      expect(@current_forecast.humidity).to eq(61)
      expect(@current_forecast.visibility).to eq(10)
      expect(@current_forecast.uvi).to eq(7.24)
      expect(@current_forecast.unix_sunrise).to eq(1587298532)
      expect(@current_forecast.unix_sunset).to eq(1587346916)
    end
  end
end
