class AddPayRateToPositionsWithMoneyGem < ActiveRecord::Migration
  def change
    add_monetize :positions, :pay_rate, currency: { present: false }
  end
end
