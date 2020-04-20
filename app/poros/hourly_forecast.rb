class HourlyForecast
  attr_reader :unix_time, :weather, :temp

  def initialize(hourly_forecast_data)
    @unix_time = hourly_forecast_data[:dt]
    @weather = hourly_forecast_data[:weather]
    @temp = hourly_forecast_data[:temp].round
  end
end
