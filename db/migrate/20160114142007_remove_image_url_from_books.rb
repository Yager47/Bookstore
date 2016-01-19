class RemoveImageUrlFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :image_url, :string
  end
end
