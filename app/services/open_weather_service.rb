class OpenWeatherService
  def self.get_weather_data(lat, lon)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params['appid'] = ENV['OPEN_WEATER_API_KEY']
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def self.conn
      Faraday.new('https://api.openweathermap.org/')
    end
end