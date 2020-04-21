require './lib/modules/jsonable'

class MapService
  include Jsonable

  def self.get_travel_time(origin, destination)
    response = conn.get('/maps/api/directions/json') do |req|
      req.params['origin'] = origin
      req.params['destination'] = destination
    end
    get_json(response)[:routes].first[:legs].first[:duration][:value]
  end

  def self.get_coordinates(query)
    response = conn.get('/maps/api/geocode/json') do |f|
      f.params['address'] = query
    end
    get_json(response)[:results].first
  end

  private

    def self.conn
      Faraday.new "https://maps.googleapis.com" do |conn|
        conn.params['key'] = ENV['GEOCODE_API_KEY']
      end
    end
end
