class ForecastFacade
  attr_reader :id, :location, :currenty, :daily, :hourly

  def initialize(query)
    @query = query
    @id = nil
  end

  def location
    geocode_data[:formatted_address]
  end

  def current
    @current ||= CurrentForecast.new(forecast_data[:current], timezone)
  end

  def hourly
    @hourly ||= forecast_data[:hourly].first(8).map do |hour|
      hour_forecast = HourlyForecast.new(hour)
      hour_time = hour_forecast.local_time(timezone)
      {hour_time => hour_forecast}
    end
  end

  def daily
    @daily ||= forecast_data[:daily].map do |day|
      day_forecast = DailyForecast.new(day)
      day_time = day_forecast.local_time(timezone)
      {day_time => day_forecast}
    end
  end

  private
    def geocode_data
      @geo_data ||= GeocodeService.get_coordinates(@query)
    end

    def forecast_data
      @weather_data ||= OpenWeatherService.get_weather_data(lat, lon)
    end

    def lat
      geocode_data[:geometry][:location][:lat]
    end

    def lon
      geocode_data[:geometry][:location][:lng]
    end

    def timezone
      forecast_data[:timezone]
    end
end