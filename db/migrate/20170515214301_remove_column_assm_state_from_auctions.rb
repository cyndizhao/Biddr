class RemoveColumnAssmStateFromAuctions < ActiveRecord::Migration[5.0]
  def change
    remove_column :auctions, :assm_state, :string
  end
end
