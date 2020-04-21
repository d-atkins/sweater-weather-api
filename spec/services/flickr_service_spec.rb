require 'rails_helper'

RSpec.describe FlickrService do
  describe 'methods' do
    describe 'get_photo' do
      it 'gets necessary background data', :vcr do
        background_data = FlickrService.get_photo('denver,co')

        expect(background_data[:url_l]).to_not be_nil
        expect(background_data[:title]).to_not be_nil
      end

      it 'handles different query formats', :vcr do
        background_data = FlickrService.get_photo('denver, colorado')

        expect(background_data[:url_l]).to_not be_nil
        expect(background_data[:title]).to_not be_nil

        background_data = FlickrService.get_photo('perth,australia')

        expect(background_data[:url_l]).to_not be_nil
        expect(background_data[:title]).to_not be_nil
      end
    end
  end
end
