class CreateSeed < ActiveRecord::Migration[7.1]
  def change
    create_table :seeds do |t|
      t.string :phrase, null: false

      t.timestamps
    end
  end
end
