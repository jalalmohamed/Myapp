class DropTableName < ActiveRecord::Migration[7.0]
  def change
    drop_table :Posts_Users
  end
end
