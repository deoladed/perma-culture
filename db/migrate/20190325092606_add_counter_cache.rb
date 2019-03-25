class AddCounterCache < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :likes_count, :integer
  	add_column :users, :posts_count, :integer
  	add_column :users, :comments_count, :integer
  	add_column :posts, :comments_count, :integer
  	add_column :posts, :likes_count, :integer
  	add_column :comments, :comments_count, :integer
  	add_column :comments, :likes_count, :integer
  end
end
