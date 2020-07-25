require "#{Rails.root}/lib/stock/stock_client_proxy.rb"
require "#{Rails.root}/lib/order/order_service.rb"
require "#{Rails.root}/lib/order/order_query.rb"

class TestController < ApplicationController
  def index
    logger2 = AnyLogger.instance
    @@any_logger.add_logs('test','This is test for flush logs', Account.system, Operation.dashboard)
    render json: {logger1: @@any_logger.object_id, logger2: logger2.object_id}, status: 200
  end

  def get_stock_list
    system_user = Account.system
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    # デフォルトの処理
    # 今まで通りに店舗在庫を取得する
    default_client = StockClientProxy.new(system_user)
    store_amount = default_client.get_stock(1)
    # 引数にEC在庫を指定するとインターフェイスを変更せずにEC在庫を取得する
    default_client = StockClientProxy.new(system_user,EcStockAdapter.new(ECStock.new))
    ec_amount = default_client.get_stock(3)
    render json: {store_amount: store_amount, ec_amount: ec_amount}, status: 200
  end

  def get_delivery_date
    # 関東: 1000000
    # 沖縄: 9000000
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    order_service = OrderService.new(1,3, "1000000")
    render json: {delivery_date_time: order_service.delivery_date_time, process: order_service.processes}, status: 200
  end

  def create_order
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    product = Product.find(1)
    ActiveRecord::Base.transaction do
      order = Order.create({
        account: shopper
      })
      ordered_product = OrderedProduct.create({
        order: order,
        product: product,
        quantity: 1
      })
      render json: {order: order, ordered_product: ordered_product}, status: 200
    end
  end

  def order_builder
    order_builder = OrderBuilder.new(1)
    order_builder.set_mask.visible_account.visible_address.visible_order_details
    render json: {order: order_builder.to_json}
  end

  def order_query
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    product = Product.find(1)
    query = OrderQuery::WithAccount.new.by_account(shopper)
    query = OrderQuery::WithProduct.new(query.relation).by_product(product).order_by(:name)
    query = query.relation.limit(10)
    render json: {query: query}
  end
end
