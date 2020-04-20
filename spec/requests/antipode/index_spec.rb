require 'rails_helper'

RSpec.describe 'Antipode API',type: :request do
  it 'sends antipode info' do
    # antipode_data = File.read('./spec/fixtures/antipode_response.json')
    # antipode_response = double("response", status: 200, body: antipode_data)
    #
    # allow_any_instance_of(Faraday::Connection).to receive(:get).with('/data/2.5/onecall').and_return(antipode_response)

    get '/api/v1/antipode?location=Hong Kong'

    expect(response).to be_successful

    antipode_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(antipode_info[:id]).to be_nil
    expect(antipode_info[:type]).to eq('antipode')
    expect(antipode_info[:attributes][:location_name]).to eq('RP69, Jujuy, Argentina')
    expect(antipode_info[:attributes][:forecast][:summary]).to eq('Clear Sky')
    expect(antipode_info[:attributes][:forecast][:current_temperature]).to eq(54)
    expect(antipode_info[:attributes][:search_location]).to eq('Hong Kong')
  end
end
