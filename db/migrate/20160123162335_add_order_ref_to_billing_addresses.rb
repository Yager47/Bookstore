class AddOrderRefToBillingAddresses < ActiveRecord::Migration
  def change
    add_reference :billing_addresses, :order, index: true, foreign_key: true
  end
end
