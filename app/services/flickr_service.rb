class FlickrService
  def self.get_photo(location)
    response = conn.get('/services/rest/') do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params['api_key'] = ENV['FLICKR_API_KEY']
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
      f.params['sort'] = 'relevance'
      f.params['per_page'] = 1
      f.params['extras'] = 'url_l,url_o'
      f.params['text'] = location
    end
    JSON.parse(response.body, symbolize_names: true)[:photos][:photo].first
  end

  private

    def self.conn
      Faraday.new("https://www.flickr.com")
    end
end
