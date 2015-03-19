class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :player_red, index: true
      t.references :player_blue, index: true
      t.integer :player_red_score
      t.integer :player_blue_score

      t.timestamps null: false
    end
    add_foreign_key :matches, :player_reds
    add_foreign_key :matches, :player_blues
  end
end
