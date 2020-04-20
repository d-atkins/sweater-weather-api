class DailyForecast < Forecast
  attr_reader :min, :max

  def initialize(daily_forecast_data)
    super(daily_forecast_data)
    @min = daily_forecast_data[:temp][:min].round
    @max = daily_forecast_data[:temp][:max].round
  end

  def day_of_week(timezone)
    local_time(timezone).strftime('%A')
  end
end
