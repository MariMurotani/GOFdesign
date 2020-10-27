class AccountFactory < AbstractFactory
  def self.create(type)
    if type == 'system'
      SystemAccount.new
    elsif type == 'admin'
      AdminAccount.new
    elsif type == 'shopper'
      ShopperAccount.new
    end
  end
end