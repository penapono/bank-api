class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :origin_id, foreign_key: true, index: true
      t.integer :destination_id, foreign_key: true, index: true
      t.string :uid

      t.timestamps
    end
  end
end
