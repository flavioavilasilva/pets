class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :nome
      t.string :raca
      t.integer :porte

      t.timestamps
    end
  end
end
