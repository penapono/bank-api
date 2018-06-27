class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :uid, index: true
      t.float :ammount
      t.references :account, foreign_key: true, index: true

      t.timestamps
    end
  end
end
