class CurrentForecast
  attr_reader :location,
              :unix_time,
              :weather,
              :temp,
              :feels_like,
              :humidity,
              :visibility,
              :uvi,
              :unix_sunrise,
              :unix_sunset

  def initialize(forecast_data)
    @unix_time = forecast_data[:dt]
    @weather = forecast_data[:weather]
    @temp = forecast_data[:temp].round
    @feels_like = forecast_data[:feels_like].round
    @humidity = forecast_data[:humidity]
    @visibility = miles(forecast_data[:visibility])
    @uvi = forecast_data[:uvi]
    @unix_sunrise = forecast_data[:sunrise]
    @unix_sunset = forecast_data[:sunset]
  end

  private
    def miles(meters)
      (meters / 1609.344).round
    end
end
