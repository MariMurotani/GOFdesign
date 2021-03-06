class TestController < ApplicationController
  before_action :only_development

  def only_development
    raise StandardError unless Rails.env == "development"
  end

  def index
    logger1 = AnyLogger.instance
    logger2 = AnyLogger.instance
    logger2.add_logs('test', 'This is test for flush logs 1', Account.system_user, Operation.dashboard)
    render json: { logger1: logger1.object_id, logger2: logger2.object_id }, status: 200
  end

  def get_stock_list
    # Adapterデザイン
    # デフォルトの処理
    # 今まで通りに店舗在庫を取得する
    default_client = StockClient.new
    store_amount = default_client.get_stock(1)
    # render json: {store_amount: store_amount}, status: 200

    # 引数にEC在庫を指定するとインターフェイスを変更せずにEC在庫を取得する
    default_client = StockClient.new(EcStockAdapter.new(ECStockClient.new))
    ec_amount = default_client.get_stock(3)
    # render json: {store_amount: store_amount, ec_amount: ec_amount}, status: 200

    # Proxyデザイン
    # 引数にEC在庫を指定するとインターフェイスを変更せずにEC在庫を取得する
    default_client = StockClientProxy.new(Account.system_user, EcStockAdapter.new(ECStockClient.new))
    # StockClientProxy::StockClientProxyAuthenticationError
    # shopper = Account.where(account_type: Account.account_types[:shopper]).last
    # default_client = StockClientProxy.new(shopper,EcStockAdapter.new(ECStockClient.new))
    ec_amount = default_client.get_stock(3)
    render json: { store_amount: store_amount, ec_amount: ec_amount }, status: 200
  end

  def get_delivery_date
    # 関東: 1000000
    # 沖縄: 9000000
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    delivery_time_estimate = DeliveryTimeEstimate.new(Product.find(2), 1, "1000000")
    render json: { delivery_date_time: delivery_time_estimate.estimate_delivery_date_time, process: delivery_time_estimate.processes }, status: 200
  end

  def create_order
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    product = Product.all.last
    ActiveRecord::Base.transaction do
      order = Order.create({
                             account: shopper
                           })
      ordered_product = OrderedProduct.create({
                                                order: order,
                                                product: product,
                                                quantity: 1
                                              })
      render json: { order: order, ordered_product: ordered_product }, status: 200
    end

    # ActiveRecord::Base.transaction do
    #   order = Order.create({
    #     account: shopper
    #   })
    #   ordered_product = OrderedProduct.create({
    #     order: order,
    #     product: product,
    #     quantity: 1
    #   })
    #
    #   total_price = Order::Billing::Price.new(20000)
    #   discount_price = Order::Billing::Price.new(20000*0.13)
    #   shipping_fee = Order::Billing::Price.new(300)
    #
    #   discounted_price = Order::Billing::Minus.new(total_price, discount_price).execute
    #   billing_amount = Order::Billing::Plus.new(discounted_price, shipping_fee).execute
    #
    #   order_bill = OrderBill.create({
    #     order: order,
    #     total_price: total_price.operand_price,
    #     discount_price: discount_price.operand_price,
    #     shipping_fee: shipping_fee.operand_price,
    #     billing_amount: billing_amount.operand_price
    #   })
    #
    #   render json: {order: order, ordered_product: ordered_product, order_bill: order_bill}, status: 200
    # end
  end

  def order_builder
    # リファクタリング前
    @order = Order.eager_load(:products, account: [:addresses, :account_rank]).all.last
    # リファクタリング後
    # query = OrderQuery::WithAccount.new(Order.where({id: 1})).relation
    # query = OrderQuery::WithProduct.new(query).relation

    order_builder = OrderBuilder.new(@order)
    order_builder.set_mask.visible_account.visible_address.visible_order_details
    render json: { order: order_builder.to_json }, status: 200
  end

  def order_builder_collection
    # リファクタリング前
    @orders = Order.eager_load(:products, account: [:addresses, :account_rank]).limit(3)
    # リファクタリング後
    # query = OrderQuery::WithAccount.new(Order.where({id: 1})).relation
    # query = OrderQuery::WithProduct.new(query).relation
    order_builder_collection = OrderBuilderCollection.new(@orders)
    order_builder_collection.set_mask
    order_builder_collection.visible_account
    collection_result = [].tap do |result|
      order_builder_collection.each do |order_builder|
        result << order_builder.to_json
      end
    end
    render json: { order: collection_result }, status: 200
  end

  def order_query
    shopper = Account.where(account_type: Account.account_types[:shopper]).last
    product = Product.all.last
    query = OrderQuery::WithAccount.new.by_account(shopper)
    query = OrderQuery::WithProduct.new(query.relation).by_product(product).order_by(:name)
    query = query.relation.limit(3)
    render json: { query: query }, status: 200
  end

  def send_mail_plain
    @order = Order.eager_load(:products, account: [:addresses, :account_rank]).all.last
    # リファクタリング後
    # query = OrderQuery::WithAccount.new(Order.where({id: 1})).relation
    # query = OrderQuery::WithProduct.new(query).relation

    order_builder = OrderBuilder.new(@order)
    order_builder.set_mask.visible_account.visible_address.visible_order_details

    text_report = ReportMail::TextReport.new(order_builder)

    render plain: text_report.output_report, status: 200

    # mail = Mail.new
    # mail.from    = "from@example.co.jp"
    # mail.to      = "to@example.co.jp"
    # mail.subject = "subject text"
    #
    # text_plain = Mail::Part.new do
    #   body "ruby mail text/plain"
    # end
    # mail.text_part = text_plain
    # #mail.deliver
  end

  def send_mail_html
    @order = Order.eager_load(:products, account: [:addresses, :account_rank]).all.last
    # リファクタリング後
    # query = OrderQuery::WithAccount.new(Order.where({id: 1})).relation
    # query = OrderQuery::WithProduct.new(query).relation

    order_builder = OrderBuilder.new(@order)
    order_builder.set_mask.visible_account.visible_address.visible_order_details

    html_report = ReportMail::HTMLReport.new(order_builder)

    render inline: html_report.output_report, status: 200

    # mail = Mail.new
    # mail.from    = "from@example.co.jp"
    # mail.to      = "to@example.co.jp"
    # mail.subject = "subject text"
    #
    # text_html = Mail::Part.new do
    #   body "<h1>ruby mail text/html</h1>"
    # end
    # mail.html_part = text_html
    # #mail.deliver
  end

  def formatter_plain
    @order = Order.eager_load(:products, account: [:addresses, :account_rank]).all.last
    # リファクタリング後
    # query = OrderQuery::WithAccount.new(Order.where({id: 1})).relation
    # query = OrderQuery::WithProduct.new(query).relation

    order_builder = OrderBuilder.new(@order)
    order_builder.set_mask.visible_account.visible_address.visible_order_details
    notify = ReportChat::Notify.new(order_builder, ReportChat::TextFormatter.new)
    render plain: notify.output, status: 200
  end
end
