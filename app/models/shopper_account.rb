class ShopperAccount < Account
  after_initialize :set_defaut_values
  def set_defaut_values
    self.account_type = Account.account_types[:shopper]
  end
end
