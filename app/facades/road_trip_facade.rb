require './lib/modules/forecastable'

class RoadTripFacade
  include Forecastable

  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @geo_location = destination
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
      if hours <= 60
        hourly_data.min_by{ |hour| (hour.unix_time - arrival_time).abs }
      else
        daily_data.min_by{ |day| (day.unix_time - arrival_time).abs }
      end
    end
end
