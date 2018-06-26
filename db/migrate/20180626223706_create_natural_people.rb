class CreateNaturalPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :natural_people do |t|
      t.string :cpf, null: false
      t.string :name
      t.date :birth

      t.timestamps
    end
  end
end
