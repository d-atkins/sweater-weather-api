class Api::V1::AntipodeController < ApplicationController
  def index
    antipode_facade = AntipodeFacade.new(params[:location])
    render json: AntipodeFacadeSerializer.new(antipode_facade)
  end
end
