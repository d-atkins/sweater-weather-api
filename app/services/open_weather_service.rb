require './lib/modules/jsonable'

class OpenWeatherService
  include Jsonable

  def self.get_weather_data(lat, lon)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['units'] = 'imperial'
    end
    get_json(response)
  end

  private

    def self.conn
      Faraday.new('https://api.openweathermap.org/') do |conn|
        conn.params['appid'] = ENV['OPEN_WEATER_API_KEY']
      end
    end
end
