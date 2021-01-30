class UpdateStockInformationJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later
    @account = Account.system_user
    @product_service = ProductService.new(@account)
    @product_service.update_stock
  end
end
