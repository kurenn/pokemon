class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.integer :pokemon_id
      t.references :trainer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
