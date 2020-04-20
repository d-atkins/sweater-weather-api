require 'rails_helper'

RSpec.describe DailyForecast do
  before(:each) do
    json_response = File.read('./spec/fixtures/weather_response.json')
    weather_data = JSON.parse(json_response, symbolize_names: true)
    @day_forecast = DailyForecast.new(weather_data[:daily].first)
  end

  describe 'attributes' do
    it 'has weather forecast info' do
      expect(@day_forecast.unix_time).to eq(1587319200)
      expect(@day_forecast.weather.first[:main]).to eq('Clear')
      expect(@day_forecast.weather.first[:description]).to eq('clear sky')
      expect(@day_forecast.weather.first[:icon]).to eq('01d')
      expect(@day_forecast.min).to eq(50)
      expect(@day_forecast.max).to eq(59)
    end
  end
end
