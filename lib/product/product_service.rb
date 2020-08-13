class ProductService
  def initialize(account)
    @logger = AnyLogger.instance
    @operation = Operation.dashboard
    @account = account
  end

  def create_or_update(params)
    @product = Product.find_or_initialize_by(id: params[:id])
    @product.attributes = {
      name: params[:name],
      description: params[:description],
      ec_stock_id: params[:ec_stock_id],
      store_stock_id: params[:store_stock_id]
    }
    @product.save!
    @logger.add_logs('Product Operation', 'Add/Update product infomation', @account, @operation)
    @product
  end

  def update_picture
    #　TODO: 画像を受け取りbase 64エンコードをしてデータを格納するメソッド
  end

  def update_stock
    #　TODO:  在庫更新JOBから呼び出されてProductモデルとStockモデルの更新をする
  end
end