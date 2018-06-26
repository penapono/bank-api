class CreateLegalPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :legal_people do |t|
      t.string :cnpj, null: false
      t.string :social_name
      t.string :fantasy_name

      t.timestamps
    end
  end
end
