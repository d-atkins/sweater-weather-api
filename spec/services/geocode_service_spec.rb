require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'methods' do
    it 'get_coordinates' do

      address_data = GeocodeService.get_coordinates('denver,co')

      expect(address_data[:location][:lat]).to eq(39.7392358)
      expect(address_data[:location][:lng]).to eq(-104.990251)
    end
  end
end
