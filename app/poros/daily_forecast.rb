class DailyForecast < Forecast
  attr_reader :min, :max, :day

  def initialize(daily_forecast_data, timezone)
    super(daily_forecast_data, timezone)
    @min = daily_forecast_data[:temp][:min].round
    @max = daily_forecast_data[:temp][:max].round
    @day = local_time
  end

  def local_time
    super.strftime("%A")
  end
end
