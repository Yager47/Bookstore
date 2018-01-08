class AddSalesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :sales, :integer
  end
end
