class HourlyForecast < Forecast
  attr_reader :temp

  def initialize(hourly_forecast_data)
    super(hourly_forecast_data)
    @temp = hourly_forecast_data[:temp].round
  end
end
