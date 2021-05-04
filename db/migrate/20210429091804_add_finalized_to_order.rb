class AddFinalizedToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :finalized, :bool, default: false
  end
end
