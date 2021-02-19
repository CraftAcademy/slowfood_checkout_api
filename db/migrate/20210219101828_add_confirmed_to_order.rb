class AddConfirmedToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :confirmed, :bool, default: false
  end
end
