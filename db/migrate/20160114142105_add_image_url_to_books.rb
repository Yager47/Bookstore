class AddImageUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :image_url, :string, :default => 'book_default.jpg'
  end
end
