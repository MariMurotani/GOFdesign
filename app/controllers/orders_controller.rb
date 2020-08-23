class OrdersController < ApplicationController
  before_action :authenticate_user, except: :auth_user
  before_action :initialize_with_authenticated_user, except: :auth_user
  skip_before_action :verify_authenticity_token
  def initialize
    super
  end
  def auth_user
    super(controller_name)
    render json: {token: session[:token]}, status:200
  end
  def initialize_with_authenticated_user
  end
  def new
    @order_service = OrderService.new(@account)
    params[:orders].each do |order|
      @order_service.add_item(order[1][:id], order[1][:amount])
    end
    @order_service.set_delivery_method(params[:delivery_method])
    @order_service.save!
    render json: @order_service, status:200
  end
  def confirm
    
  end
end