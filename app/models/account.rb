class Account < ApplicationRecord
  has_one :order
  has_many :address, dependent: :destroy
  enum account_type: { administrator: 0, shopper: 1 }

  def self.new_user(target)
    case target
    when 'ADMIN'
      self.new({account_type: Account.account_types[:administrator]})
    when 'SHOPPER'
      self.new({account_type: Account.account_types[:shopper]})
    end
  end
end