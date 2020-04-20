class AntipodeFacadeSerializer
  include FastJsonapi::ObjectSerializer
  set_type :antipode
  attributes :location_name, :forecast, :search_location
end
