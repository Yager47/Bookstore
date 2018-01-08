class AddOrderRefToShippingAddresses < ActiveRecord::Migration
  def change
    add_reference :shipping_addresses, :order, index: true, foreign_key: true
  end
end
