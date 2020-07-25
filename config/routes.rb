Rails.application.routes.draw do
  get 'test/index'
  get 'test/get_stock_list'
  get 'test/get_delivery_date'
  get 'test/create_order'
  get 'test/order_builder'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
