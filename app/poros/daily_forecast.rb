class DailyForecast < Forecast
  attr_reader :min, :max

  def initialize(daily_forecast_data)
    super(daily_forecast_data)
    @min = daily_forecast_data[:temp][:min].round
    @max = daily_forecast_data[:temp][:max].round
  end

  def local_time(timezone)
    super(timezone).strftime("%A")
  end
end
