class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :num
      t.timestamps
    end
  end
end
