class Account < ApplicationRecord
  include ActiveModel::Serialization
  has_many :order
  has_one :account_rank, dependent: :destroy
  has_many :address, dependent: :destroy
  enum account_type: { system: 0, administrator: 1, shopper: 2 }
  scope :system, -> { where(account_type: Account.account_types[:system]).last }
  def self.new_user(target)
    case target
    when 'SYSTEM'
      self.new({account_type: Account.account_types[:system]})
    when 'ADMIN'
      self.new({account_type: Account.account_types[:administrator]})
    when 'SHOPPER'
      self.new({account_type: Account.account_types[:shopper]})
    end
  end
  def attributes
    {
      'id': nil,
      'name': nil
    }
  end
end