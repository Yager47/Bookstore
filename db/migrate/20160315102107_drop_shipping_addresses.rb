class DropShippingAddresses < ActiveRecord::Migration
  def change
    drop_table :shipping_addresses
  end
end
