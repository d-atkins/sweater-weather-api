require 'rails_helper'

RSpec.describe 'Antipode API',type: :request do
  it 'sends antipode info' do
    get '/api/v1/antipode?location=Hong Kong'

    expect(response).to be_successful

    antipode_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(antipode_info[:id]).to be_nil
    expect(antipode_info[:type]).to eq('antipode')
    expect(antipode_info[:attributes][:location_name]).to eq('RP69, Jujuy, Argentina')
    expect(antipode_info[:attributes][:forecast][:summary]).to_not be_empty
    expect(antipode_info[:attributes][:forecast][:summary]).to be_instance_of(String)
    expect(antipode_info[:attributes][:forecast][:current_temperature]).to be_instance_of(Integer)
    expect(antipode_info[:attributes][:search_location]).to eq('Hong Kong')
  end
end
