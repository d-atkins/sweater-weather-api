class GeocodeService
  def self.get_coordinates(query)
    response = conn.get('/maps/api/geocode/json') do |f|
      f.params['key'] = ENV['GEOCODE_API_KEY']
      f.params['address'] = query
    end
    JSON.parse(response.body, symbolize_names: true)[:results].first
  end

  def self.get_location(lat, long)
    response = conn.get('/maps/api/geocode/json') do |f|
      f.params['key'] = ENV['GEOCODE_API_KEY']
      f.params['latlng'] = "#{lat},#{long}"
    end
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  private

    def self.conn
      Faraday.new("https://maps.googleapis.com")
    end
end
