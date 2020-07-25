class OrderObserver < ActiveRecord::Observer
  def after_create(order)
    current_time = Time.zone.now
    past_time = current_time.months_ago(3)
    return if order.account.account_rank && order.account.updated_at > current_time.months_ago(1)
    target_order = Order.where(account: order.account).where(updated_at: past_time..current_time)
    if target_order.length > 3
      account_rank = order.account.account_rank || AccountRank.new({account: order.account, rank: 0})
      account_rank.rank += 1
      account_rank.save!
    end
  end
end
