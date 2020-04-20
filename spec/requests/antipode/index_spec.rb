require 'rails_helper'

RSpec.describe 'Antipode API',type: :request do
  it 'sends antipode info' do
    # antipode_data = File.read('./spec/fixtures/antipode_response.json')
    # antipode_response = double("response", status: 200, body: antipode_data)
    #
    # allow_any_instance_of(Faraday::Connection).to receive(:get).with('/data/2.5/onecall').and_return(antipode_response)

    get '/api/v1/antipode?location=Hong Kong'

    expect(response).to be_successful

    antipode_info = JSON.parse(response.body, symbolize_names: true)

    expect(antipode_info[:location_name]).to eq('Some City in Argentina')
    expect(antipode_info[:forecast][:summary]).to eq('Some weather')
    expect(antipode_info[:forecast][:current_temperature]).to eq(123)
    expect(antipode_info[:search_location]).to eq('Hong Kong')
  end
end
