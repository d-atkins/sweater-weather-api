class MapService
  def self.get_travel_time(origin, destination)
    response = conn.get('/maps/api/directions/json') do |req|
      req.params['origin'] = origin
      req.params['destination'] = destination
    end
    get_json(response)[:routes].first[:legs].first[:duration][:value]
  end

  private

    def self.conn
      Faraday.new "https://maps.googleapis.com" do |conn|
        conn.params['key'] = ENV['GEOCODE_API_KEY']
      end
    end

    def self.get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
