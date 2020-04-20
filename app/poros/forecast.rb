class Forecast
  attr_reader :unix_time, :weather

  def initialize(data, timezone)
    @unix_time = data[:dt]
    @weather = data[:weather]
    @timezone = timezone
  end

  def local_time
    Time.at(@unix_time).in_time_zone(@timezone)
  end
end
