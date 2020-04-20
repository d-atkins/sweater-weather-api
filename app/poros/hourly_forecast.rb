class HourlyForecast < Forecast
  attr_reader :temp

  def initialize(hourly_forecast_data)
    super(hourly_forecast_data)
    @temp = hourly_forecast_data[:temp].round
  end

  def local_time(timezone)
    super(timezone).strftime("%l %p").strip
  end
end
