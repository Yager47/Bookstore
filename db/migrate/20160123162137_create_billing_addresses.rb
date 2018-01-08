class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.string :city
      t.string :street
      t.string :phone
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
