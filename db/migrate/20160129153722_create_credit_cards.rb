class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :cvv
      t.date :expiration_date

      t.timestamps null: false
    end
  end
end
