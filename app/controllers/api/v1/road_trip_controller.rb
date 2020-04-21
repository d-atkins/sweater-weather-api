class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: user_params[:api_key])
    if user
      road_trip_facade = RoadTripFacade.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip_facade)
    else
      render json: error, status: 401
    end
  end

  private

    def user_params
      params.permit(:api_key)
    end

    def error
      {Status: 401, Error: 'Unauthorized'}
    end
end
