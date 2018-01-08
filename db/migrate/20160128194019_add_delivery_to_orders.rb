class AddDeliveryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery, :decimal, :default => 0.0
  end
end
