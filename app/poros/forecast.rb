class Forecast
  attr_reader :unix_time, :weather

  def initialize(data)
    @unix_time = data[:dt]
    @weather = data[:weather]
  end

  def local_time(timezone)
    Time.at(@unix_time).in_time_zone(timezone)
  end
end
