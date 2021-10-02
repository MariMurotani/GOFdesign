class ShopperAccount < Account
  after_initialize :set_defaut_values
  def set_defaut_values
    self.account_type = :shopper
  end
end
