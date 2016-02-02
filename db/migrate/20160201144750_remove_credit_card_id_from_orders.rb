class RemoveCreditCardIdFromOrders < ActiveRecord::Migration
  def change
    remove_reference :orders, :credit_card, index: true, foreign_key: true
  end
end
