class AdminAccount < Account
  after_initialize :set_defaut_values
  def set_defaut_values
    self.account_type = :administrator
  end
end
