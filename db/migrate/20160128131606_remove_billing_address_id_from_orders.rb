class RemoveBillingAddressIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :billing_address_id, :integer
  end
end
