require "#{Rails.root}/lib/stock/stock_client_proxy.rb"
require "#{Rails.root}/lib/order/order_service.rb"

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
    binding.pry
    order_service = OrderService.new(1,5, "1000000")
    render json: {delivery_date_time: order_service.get_delivery_date_time, process: order_service.process}, status: 200
  end
end
