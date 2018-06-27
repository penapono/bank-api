class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :origin_id, foreign_key: true
      t.integer :destination_id, foreign_key: true
      t.float :ammount

      t.timestamps
    end
  end
end
