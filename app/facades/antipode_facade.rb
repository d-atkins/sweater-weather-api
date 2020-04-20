class AntipodeFacade
  attr_reader :location_name, :forecast, :search_location

  def initialize(location)
    @location = location
    # require "pry"; binding.pry
  end

  def location_name

  end

  def forecast
    antipode_forecast = Hash.new
    antipode_forecast[:summary] = antipode_weather[:weather].first[:description].titlecase
    antipode_forecast[:current_temperature] = antipode_weather[:temp].round
    antipode_forecast
  end

  def search_location
    @location
  end

  private

    def origin_coordinates
      @origin_coordinates ||= GeocodeService.get_coordinates(@location)[:geometry][:location]
    end

    def antipode_coordinates
      @antipode_coordinates ||= AntipodeService.get_antipode_coordinates(origin_coordinates[:lat], origin_coordinates[:lng])[:attributes]
    end

    def antipode_weather
      @antipode_weather ||= OpenWeatherService.get_weather_data(antipode_coordinates[:lat], antipode_coordinates[:long])[:current]
    end
end
