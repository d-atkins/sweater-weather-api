require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    json_response = File.read('./spec/fixtures/weather_response.json')
    weather_data = JSON.parse(json_response, symbolize_names: true)
    @forecast = Forecast.new(weather_data[:current])
  end

  describe 'attributes' do
    it 'has weather forecast info' do
      expect(@forecast.unix_time).to eq(1587325934)
      expect(@forecast.weather.first[:main]).to eq('Clear')
      expect(@forecast.weather.first[:description]).to eq('clear sky')
      expect(@forecast.weather.first[:icon]).to eq('01d')
    end
  end

  describe 'methods' do
    it 'local time' do
      expect(@forecast.local_time('America/Denver').strftime("%I:%M %p")).to eq ("01:52 PM")
    end
  end
end
