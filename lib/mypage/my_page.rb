class MyPage
  def initialize(account)
    @account = account
  end
  def orders(limit=10)
    query = OrderQuery::WithAccount.new.by_account(@account)
    query = OrderQuery::WithProduct.new(query.relation).order_by(' created_at desc').order_by(:name)
    query = query.relation.limit(limit)
  end
end