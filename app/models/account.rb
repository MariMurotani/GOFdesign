class Account < ApplicationRecord
  include ActiveModel::Serialization
  has_many :oreders
  has_one :account_rank, dependent: :destroy
  has_many :addresses, dependent: :destroy
  enum account_type: { systemadmin: 0, administrator: 1, shopper: 2 }
  scope :system_user, -> { where(account_type: Account.account_types[:systemadmin]).last }
  def self.create_user(target)
    case target
    when 'SYSTEM'
      self.new({ account_type: Account.account_types[:systemadmin] })
    when 'ADMIN'
      self.new({ account_type: Account.account_types[:administrator] })
    when 'SHOPPER'
      self.new({ account_type: Account.account_types[:shopper] })
    end
  end

  def attributes
    {
      'id': nil,
      'name': nil
    }
  end
end
