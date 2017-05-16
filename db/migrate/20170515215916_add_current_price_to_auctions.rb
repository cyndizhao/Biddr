class AddCurrentPriceToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :current_price, :integer, default: 1
  end
end
