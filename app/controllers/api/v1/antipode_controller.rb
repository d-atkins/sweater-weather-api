class Api::V1::AntipodeController < ApplicationController
  def index
    if (params[:location])
      antipode_facade = AntipodeFacade.new(params[:location])
      render json: AntipodeFacadeSerializer.new(antipode_facade)
    else
      render json: error
    end
  end

  private
    def error
      {
        error_message: "Invalid request. Missing the 'location' parameter.",
        status: "INVALID REQUEST"
      }
    end
end
