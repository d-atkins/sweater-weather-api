require 'rails_helper'

RSpec.describe Background do
  before(:each) do
    background_json = File.read('./spec/fixtures/background_response.json')
    background_info = JSON.parse(background_json, symbolize_names: true)
    @background = Background.new(background_info[:photos][:photo].first)
  end

  describe 'attributes' do
    it 'has weather forecast info' do
      expect(@background.url_l).to eq('https://live.staticflickr.com/7778/17268897900_e32be36b48_b.jpg')
      expect(@background.url_o).to be_nil
      expect(@background.title).to eq("First Flatiron Northface")
    end
  end
end
