class CreateInsides < ActiveRecord::Migration[7.0]
  def change
    create_table :insides do |t|
      t.string :commenter
      t.text :body
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
