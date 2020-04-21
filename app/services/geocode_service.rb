class GeocodeService
  def self.get_coordinates(query)
    response = conn.get('/maps/api/geocode/json') do |f|
      f.params['key'] = ENV['GEOCODE_API_KEY']
      f.params['address'] = query
    end
    get_json(response)[:results].first
  end

  private

    def self.conn
      Faraday.new("https://maps.googleapis.com")
    end

    def self.get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
