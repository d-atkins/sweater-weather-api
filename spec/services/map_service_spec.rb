require 'rails_helper'

RSpec.describe MapService do
  describe 'methods' do
    it 'get_travel_time', :vcr do
      travel_time = MapService.get_travel_time('denver,co', 'boulder,co')

      expect(travel_time).to_not be_nil
      expect(travel_time).to be_instance_of(Integer)
    end

    it 'get_coordinates', :vcr do
      address_data = MapService.get_coordinates('denver,co')

      expect(address_data[:formatted_address]).to eq('Denver, CO, USA')
      expect(address_data[:geometry][:location][:lat]).to eq(39.7392358)
      expect(address_data[:geometry][:location][:lng]).to eq(-104.990251)

      address_data = MapService.get_coordinates('portland,or')

      expect(address_data[:formatted_address]).to eq('Portland, OR, USA')
      expect(address_data[:geometry][:location][:lat]).to eq(45.5051064)
      expect(address_data[:geometry][:location][:lng]).to eq(-122.6750261)
    end
  end
end
