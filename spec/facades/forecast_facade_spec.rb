require 'rails_helper'

RSpec.describe ForecastFacade, type: :model do
  describe 'methods' do
    before(:each) do
      @forecast_facade = ForecastFacade.new('Orlando,FL')
    end

    it 'location', :vcr do
      expect(@forecast_facade.location).to eq ("Orlando, FL, USA")
    end

    it 'current', :vcr do
      expect(@forecast_facade.current).to be_instance_of(CurrentForecast)
    end

    it 'hourly', :vcr do
      expect(@forecast_facade.hourly).to be_instance_of(Array)
      @forecast_facade.hourly.each do |hour_forecast|
        expect(hour_forecast).to be_instance_of(HourlyForecast)
      end
    end

    it 'daily', :vcr do
      expect(@forecast_facade.daily).to be_instance_of(Array)
      @forecast_facade.daily.each do |day_forecast|
        expect(day_forecast).to be_instance_of(DailyForecast)
      end
    end
  end
end
