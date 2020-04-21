require 'rails_helper'

RSpec.describe MapService do
  describe 'methods' do
    it 'get_travel_time', :vcr do
      travel_time = MapService.get_travel_time('denver,co', 'boulder,co')

      expect(travel_time).to_not be_nil
      expect(travel_time).to be_instance_of(Integer)
    end
  end
end
