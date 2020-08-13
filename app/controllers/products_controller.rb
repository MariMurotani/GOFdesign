class ProductsController < ApplicationController
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
    @product_service = ProductService.new(@account)
    @operation = Operation.where({name: "admin dashboard"}).last
  end

  def new
    @product = @product_service.create_or_update(params)
    render json: @product.to_json, status:200
  end
end