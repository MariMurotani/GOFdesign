class ProductsController < ApplicationController
  before_action :authenticate_user, except: :auth_user

  def initialize
    super
    @product_service = ProductService.new
    @operation = Operation.where({name: "admin dashboard"}).last
  end

  def auth_user
    super(controller_name)
    render json: {token: session[:token]}, status:200
  end

  def new
    params.require([:token])
    binding.pry
    @product_service.add_new_product(params)
    # logger.add_logs('test1', 'test1test1test1', Account.system_user, Operation.last)
  end
end