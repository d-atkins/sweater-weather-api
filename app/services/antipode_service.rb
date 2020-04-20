class AntipodeService
  def self.get_antipode_coordinates(lat, long)
    response = conn.get('/api/v1/antipodes') do |f|
      f.params['lat'] = lat
      f.params['long'] = long
      f.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  private

    def self.conn
      Faraday.new("http://amypode.herokuapp.com")
    end
end
