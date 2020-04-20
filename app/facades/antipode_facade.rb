class AntipodeFacade
  attr_reader :id, :location_name, :forecast, :search_location

  def initialize(location)
    @location = location
    @id = nil
  end

  def location_name
    antipode_location_name
  end

  def forecast
    antipode_forecast = Hash.new
    antipode_forecast[:summary] = antipode_weather_summary
    antipode_forecast[:current_temperature] = antipode_current_temp
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

    def antipode_location_data
      @antipode_location_data ||= GeocodeService.get_location(antipode_coordinates[:lat], antipode_coordinates[:long])
    end

    def antipode_location_name
      antipode_location_data.first[:formatted_address]
    end

    def antipode_weather_summary
      antipode_weather[:weather].first[:description].titlecase
    end

    def antipode_current_temp
      antipode_weather[:temp].round
    end
end
