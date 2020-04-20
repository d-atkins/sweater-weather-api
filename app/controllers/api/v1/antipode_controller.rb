class Api::V1::AntipodeController < ApplicationController
  def index
    # forecast = ForecastFacade.new(params[:location])
    # render json: ForecastFacadeSerializer.new(forecast)
    location_coordinates = GeocodeService.get_coordinates(params[:location])
    lat = location_coordinates[:geometry][:location][:lat]
    long = location_coordinates[:geometry][:location][:lng]
    antipode_coordinates = AntipodeService.get_antipode_coordinates(lat, long)
    anti_lat = antipode_coordinates[:attributes][:lat]
    anti_long = antipode_coordinates[:attributes][:long]

    antipode_weather = OpenWeatherService.get_weather_data(anti_lat, anti_long)
  end
end
