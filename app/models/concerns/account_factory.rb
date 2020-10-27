class AccountFactory < AbstractFactory
  def self.create_user(type)
    if type == 'system'
      SystemAccount.new
    else
      Account.new
    end
  end
end