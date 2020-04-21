module Forecastable
  private
  def geocode_data
    @geo_data ||= MapService.get_coordinates(@geo_location)
  end

  def coordinates
    geocode_data[:geometry][:location]
  end

  def timezone
    forecast_data[:timezone]
  end

  def forecast_data
    @weather_data ||= OpenWeatherService.get_weather_data(coordinates[:lat], coordinates[:lng])
  end

  def current_data
    @current_data ||= CurrentForecast.new(forecast_data[:current], timezone)
  end

  def hourly_data
    @hourly_data ||= forecast_data[:hourly].map { |hour| HourlyForecast.new(hour, timezone) }
  end

  def daily_data
    @daily_data ||= forecast_data[:daily].map { |day| DailyForecast.new(day, timezone) }
  end
end
