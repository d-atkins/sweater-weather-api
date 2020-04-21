class Api::V1::BackgroundsController < ApplicationController
  def index
    background_data = FlickrService.get_photo(params[:location])
    background = Background.new(background_data)
    render json: BackgroundSerializer.new(background)
  end
end
