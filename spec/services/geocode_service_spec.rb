require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'methods' do
    it 'get_coordinates' do

      address_data = GeocodeService.get_coordinates('denver,co')['data']['address_components']["formatted_address"]

      expect(address_data['location']['lat']).to eq(39.91424689999999)
      expect(address_data['location']['lng']).to eq(-104.6002959)
    end
  end
end
