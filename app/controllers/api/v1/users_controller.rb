class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: error(user), status: 400
    end
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

    def error(user)
      {Status: 400, Error: user.errors.full_messages.to_sentence.capitalize}
    end
end
