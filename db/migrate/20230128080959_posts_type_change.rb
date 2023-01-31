class PostsTypeChange < ActiveRecord::Migration[7.0]
  def up
    change_column_null :posts,:created_at,:datetime, false
    change_column_null :posts,:updated_at,:datetime, false
  end
  def down
    remove_column :posts, :created_at
    remove_column :posts, :updated_at
  end
end
