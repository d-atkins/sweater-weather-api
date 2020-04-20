class CurrentForecast < Forecast
  attr_reader :location,
              :temp,
              :feels_like,
              :humidity,
              :visibility,
              :uvi,
              :unix_sunrise,
              :unix_sunset,
              :local_time

  def initialize(forecast_data, timezone)
    super(forecast_data)
    @temp = forecast_data[:temp].round
    @feels_like = forecast_data[:feels_like].round
    @humidity = forecast_data[:humidity]
    @visibility = miles(forecast_data[:visibility])
    @uvi = forecast_data[:uvi]
    @unix_sunrise = forecast_data[:sunrise]
    @unix_sunset = forecast_data[:sunset]
    @timezone = timezone
    @current_time = local_time
  end

  def local_time
    super(@timezone).strftime("%l:%M %p, %B %e").strip
  end

  private
    def miles(meters)
      (meters / 1609.344).round
    end
end
