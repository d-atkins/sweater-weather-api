class CurrentForecast
  attr_reader :location,
              :unix_time,
              :main,
              :description,
              :temp,
              :high,
              :low,
              :feels_like,
              :humidity,
              :visibility,
              :uvi,
              :unix_sunrise,
              :unix_sunset,
              :icon

  def initialize(forecast_data, location)
    @location = location
    @unix_time = forecast_data[:current][:dt]
    @main = forecast_data[:current][:weather].first[:main]
    @description = forecast_data[:current][:weather].first[:description]
    @icon = forecast_data[:current][:weather].first[:icon]
    @temp = forecast_data[:current][:temp].round
    @high = forecast_data[:daily].first[:temp][:max].round
    @low = forecast_data[:daily].first[:temp][:min].round
    @feels_like = forecast_data[:current][:feels_like].round
    @humidity = forecast_data[:current][:humidity]
    @visibility = miles(forecast_data[:current][:visibility])
    @uvi = forecast_data[:current][:uvi]
    @unix_sunrise = forecast_data[:current][:sunrise]
    @unix_sunset = forecast_data[:current][:sunset]
  end

  private
    def miles(meters)
      (meters / 1609.344).round
    end
end
