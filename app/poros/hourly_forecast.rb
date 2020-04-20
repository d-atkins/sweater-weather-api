class HourlyForecast < Forecast
  attr_reader :temp, :time

  def initialize(hourly_forecast_data, timezone)
    super(hourly_forecast_data, timezone)
    @temp = hourly_forecast_data[:temp].round
    @time = local_time
  end

  def local_time
    super.strftime("%l %p").strip
  end
end
