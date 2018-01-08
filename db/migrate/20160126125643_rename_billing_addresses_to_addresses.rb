class RenameBillingAddressesToAddresses < ActiveRecord::Migration
  def change
    rename_table :billing_addresses, :addresses
  end
end
