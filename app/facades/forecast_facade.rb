require './lib/modules/forecastable'

class ForecastFacade
  include Forecastable

  attr_reader :id, :location, :currenty, :daily, :hourly

  def initialize(location_query)
    @location_query = location_query
    @geo_location = location_query
  end

  def location
    geocode_data[:formatted_address]
  end

  def current
    current_data
  end

  def hourly
    hourly_data.first(8)
  end

  def daily
    daily_data
  end
end
