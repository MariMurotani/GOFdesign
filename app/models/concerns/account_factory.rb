class AccountFactory < AbstractFactory
  def self.create(type)
    if type == 'system'
      SystemAccount.new
    else
      Account.new
    end
  end
end