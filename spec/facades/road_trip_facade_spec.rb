require 'rails_helper'

RSpec.describe RoadTripFacade, type: :model do
  describe 'methods' do
    before(:each) do
      @road_trip_facade = RoadTripFacade.new('Denver,CO', 'Pueblo,CO')
    end

    it 'origin', :vcr do
      expect(@road_trip_facade.origin).to eq ('Denver,CO')
    end

    it 'destination', :vcr do
      expect(@road_trip_facade.destination).to eq ('Pueblo,CO')
    end

    it 'travel_time', :vcr do
      expect(@road_trip_facade.travel_time).to be_instance_of(String)
      expect(@road_trip_facade.travel_time).to_not be_empty
    end

    it 'arrival_forecast', :vcr do
      expect(@road_trip_facade.arrival_forecast.temp).to be_instance_of(Integer)
      expect(@road_trip_facade.arrival_forecast.weather.first[:description]).to be_instance_of(String)
      expect(@road_trip_facade.arrival_forecast.weather.first[:description]).to_not be_empty
    end
  end
end
