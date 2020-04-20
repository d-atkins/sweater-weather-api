require 'rails_helper'

RSpec.describe CurrentForecast do
  before(:each) do
    json_response = File.read('./spec/fixtures/weather_response.json')
    weather_data = JSON.parse(json_response, symbolize_names: true)
    @current_forecast = CurrentForecast.new(weather_data[:current], 'America/Denver')
  end

  describe 'attributes' do
    it 'has weather forecast info' do
      expect(@current_forecast.unix_time).to eq(1587325934)
      expect(@current_forecast.weather.first[:main]).to eq('Clear')
      expect(@current_forecast.weather.first[:description]).to eq('clear sky')
      expect(@current_forecast.weather.first[:icon]).to eq('01d')
      expect(@current_forecast.temp).to eq(54)
      expect(@current_forecast.feels_like).to eq(50)
      expect(@current_forecast.humidity).to eq(61)
      expect(@current_forecast.visibility).to eq(10)
      expect(@current_forecast.uvi).to eq(7.24)
      expect(@current_forecast.unix_sunrise).to eq(1587298532)
      expect(@current_forecast.unix_sunset).to eq(1587346916)
    end
  end

  describe 'methods' do
    it 'local time' do
      expect(@current_forecast.local_time).to eq (" 1:52 PM, April 19")
    end
  end
end
