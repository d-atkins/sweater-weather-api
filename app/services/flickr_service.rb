require './lib/modules/jsonable'
require './lib/modules/stateable'

class FlickrService
  include Stateable, Jsonable

  def self.get_photo(location)
    response = conn.get('/services/rest/') do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params['sort'] = 'relevance'
      f.params['per_page'] = 1
      f.params['extras'] = 'url_l,url_o'
      f.params['text'] = formatted_search(location)
    end
    get_json(response)[:photos][:photo].first
  end

  private

    def self.conn
      Faraday.new("https://www.flickr.com") do |conn|
        conn.params['api_key'] = ENV['FLICKR_API_KEY']
        conn.params['format'] = 'json'
        conn.params['nojsoncallback'] = 1
      end
    end

    def self.formatted_search(location)
      comma_separated = location.split(',')
      return comma_separated[0] if comma_separated.length == 1
      state = comma_separated.delete_at(-1)
      "#{comma_separated.join} #{get_state(state)}"
    end
end
