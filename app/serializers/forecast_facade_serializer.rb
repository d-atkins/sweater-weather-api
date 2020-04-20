class ForecastFacadeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :current, :hourly, :daily
end
