class CreateJoinTablePostUser2 < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :users, table_name: 'posts_users_read_status' do |t|
      t.index [:post_id, :user_id]
      t.index [:user_id, :post_id]
    end
  end
end
