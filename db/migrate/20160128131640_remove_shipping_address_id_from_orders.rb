class RemoveShippingAddressIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :shipping_address_id, :integer
  end
end
