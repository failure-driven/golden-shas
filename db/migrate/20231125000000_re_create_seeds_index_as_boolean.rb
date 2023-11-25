class ReCreateSeedsIndexAsBoolean < ActiveRecord::Migration[7.1]
  def up
    drop_table :seeds
    create_table :seeds, id: :boolean do |t|
      t.string :phrase, null: false

      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
