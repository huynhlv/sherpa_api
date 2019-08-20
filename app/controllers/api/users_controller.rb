class Api::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: %i(show update destroy)

  def show
    user = current_user

    if user
      render json: user
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def create
    user = User.new(user_params)
    user.generate_authentication_token!
    if user.save
      sign_in(user, store: false)
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
