class MypagesController < ApplicationController
  before_action :authenticate_user, except: :auth_user
  before_action :initialize_with_authenticated_user, except: :auth_user

  def initialize
    super
  end

  def auth_user
    super(controller_name)
    render json: {token: session[:token]}, status:200
  end

  def initialize_with_authenticated_user
  end

  def orders
    orders = MyPage.new(@account).orders
    render json: orders, status: 200
  end
end