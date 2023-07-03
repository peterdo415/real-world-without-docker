class AddImageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image, :string
    add_column :users, :bio, :text
  end
end
