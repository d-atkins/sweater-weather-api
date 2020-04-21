class RoadTripFacade
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def arrival_forecast
    get_nearest_forecast
  end

  def travel_time
    display_duration
  end

  private
    def travel_time_seconds
      @travel_time_seconds ||= MapService.get_travel_time(@origin, @destination)
    end

    def arrival_time
      forecast_data[:current][:dt] + travel_time_seconds
    end

    def hours
      @hours ||= travel_time_seconds / 3600
    end

    def minutes
      @minutes ||= (travel_time_seconds % 3600) / 60
    end

    def display_duration
      display = ''
      if hours > 0
        display << "#{hours} hour"
        display << 's' if hours > 1
        display << ', '
      end
      display << "#{minutes} minute"
      display << 's' if minutes == 0 || minutes > 1
    end

    def get_nearest_forecast
      if hours <= 48
        hourly.min_by{ |hour| (hour.unix_time - arrival_time).abs }
      else
        daily.min_by{ |day| (day.unix_time - arrival_time).abs }
      end
    end

    def geocode_data
      @geo_data ||= MapService.get_coordinates(@destination)
    end

    def coordinates
      geocode_data[:geometry][:location]
    end

    def forecast_data
      @weather_data ||= OpenWeatherService.get_weather_data(coordinates[:lat], coordinates[:lng])
    end

    def hourly
      @hourly ||= forecast_data[:hourly].map { |hour| HourlyForecast.new(hour, forecast_data[:timezone]) }
    end

    def daily
      @daily ||= forecast_data[:daily].map { |day| DailyForecast.new(day, forecast_data[:timezone]) }
    end
end
