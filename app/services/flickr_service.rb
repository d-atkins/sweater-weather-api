require './lib/modules/jsonable'

class FlickrService
  include Jsonable

  def self.get_photo(location)
    response = conn.get('/services/rest/') do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params['sort'] = 'relevance'
      f.params['per_page'] = 1
      f.params['extras'] = 'url_l,url_o'
      f.params['text'] = location
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
end
