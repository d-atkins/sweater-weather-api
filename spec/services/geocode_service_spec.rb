require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'methods' do
    describe 'get_coordinates' do
      it 'gets name, latitude, and longitude from a valid search' do
        address_data = GeocodeService.get_coordinates('denver,co')

        expect(address_data[:formatted_address]).to eq('Denver, CO, USA')
        expect(address_data[:geometry][:location][:lat]).to eq(39.7392358)
        expect(address_data[:geometry][:location][:lng]).to eq(-104.990251)

        address_data = GeocodeService.get_coordinates('portland,or')

        expect(address_data[:formatted_address]).to eq('Portland, OR, USA')
        expect(address_data[:geometry][:location][:lat]).to eq(45.5051064)
        expect(address_data[:geometry][:location][:lng]).to eq(-122.6750261)
      end

      it 'returns nil for an invalid search' do
        address_data = GeocodeService.get_coordinates('aeirjslas,lk')

        expect(address_data).to be_nil
      end
    end
  end
end
