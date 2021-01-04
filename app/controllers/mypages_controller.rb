class MypagesController < ApplicationController
  before_action :authenticate_user, except: :auth_user
  before_action :initialize_with_authenticated_user, except: :auth_user
  skip_before_action :verify_authenticity_token

  def initialize
    super
  end

  def initialize_with_authenticated_user
  end

  def auth_user
    super(controller_name)
    render json: {token: session[:token]}, status:200
  end

  def orders
    orders = MypageService.new(@account).orders
    render json: orders, status: 200
  end
end