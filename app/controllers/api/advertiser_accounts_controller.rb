class Api::AdvertiserAccountsController < ApplicationController
  before_action :authenticate_with_token!
  before_action :load_advertiser, only: :destroy

  def create
    advertiser = current_user.advertiser_accounts.build(advertiser_params)
    if advertiser.save
      render json: advertiser, status: 201, location: [:api, advertiser]
    else
      render json: { errors: advertiser.errors }, status: 422
    end
  end

  def index
    render json: current_user.advertiser_accounts if current_user
  end

  def destroy
    @advertiser.destroy
    head 204
  end

  private

  def advertiser_params
    params.permit(:email)
  end

  def load_advertiser
    @advertiser = AdvertiserAccount.find_by(email: params[:email])
    return if @advertiser
    render json: 'Not find advertiser', status: 404
  end
end
