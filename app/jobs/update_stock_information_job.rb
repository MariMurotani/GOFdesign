class UpdateStockInformationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    @account = Account.system
    @product_service = ProductService.new(@account)
    @product_service.update_stock
  end
end
