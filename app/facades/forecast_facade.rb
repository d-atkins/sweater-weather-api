class ForecastFacade
  attr_reader :id, :location, :currenty, :daily, :hourly

  def initialize(query)
    @query = query
  end

  def location
    geocode_data[:formatted_address]
  end

  def current
    @current ||= CurrentForecast.new(forecast_data[:current], timezone)
  end

  def hourly
    @hourly ||= forecast_data[:hourly].first(8).map { |hour| HourlyForecast.new(hour, timezone) }
  end

  def daily
    @daily ||= forecast_data[:daily].map { |day| DailyForecast.new(day, timezone) }
  end

  private
    def geocode_data
      @geo_data ||= MapService.get_coordinates(@query)
    end

    def coordinates
      geocode_data[:geometry][:location]
    end

    def forecast_data
      @weather_data ||= OpenWeatherService.get_weather_data(coordinates[:lat], coordinates[:lng])
    end

    def timezone
      forecast_data[:timezone]
    end
end
