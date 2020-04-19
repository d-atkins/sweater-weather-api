require 'rails_helper'

RSpec.describe OpenWeatherService do
  describe 'methods' do
    describe 'get_forecast' do
      it 'gets necessary forecast data for valid search' do
        coordinates = {lat: 39.7392358, long: -104.990251}
        forecast_data = OpenWeatherService.get_weather_data(coordinates[:lat], coordinates[:long])

        expect(forecast_data[:current][:weather].first[:icon]).to_not be_nil
        expect(forecast_data[:current][:weather].first[:main]).to_not be_nil
        expect(forecast_data[:current][:weather].first[:description]).to_not be_nil
        expect(forecast_data[:current][:temp]).to_not be_nil
        expect(forecast_data[:current][:feels_like]).to_not be_nil
        expect(forecast_data[:current][:humidity]).to_not be_nil
        expect(forecast_data[:current][:visibility]).to_not be_nil
        expect(forecast_data[:current][:uvi]).to_not be_nil
        expect(forecast_data[:current][:dt]).to_not be_nil
        expect(forecast_data[:current][:sunrise]).to_not be_nil
        expect(forecast_data[:current][:sunset]).to_not be_nil

        expect(forecast_data[:hourly]).to_not be_empty
        expect(forecast_data[:daily].length).to eq(8)
      end
    end
  end
end
