class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      #t.belongs_to :topic, index: true, foreign_key: true
      t.string :name
      t.date :publish

      t.timestamps
    end
  end
end
