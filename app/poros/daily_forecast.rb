class DailyForecast
  attr_reader :unix_time, :weather, :min, :max

  def initialize(hourly_forecast_data)
    @unix_time = hourly_forecast_data[:dt]
    @weather = hourly_forecast_data[:weather]
    @min = hourly_forecast_data[:temp][:min].round
    @max = hourly_forecast_data[:temp][:max].round
  end
end
