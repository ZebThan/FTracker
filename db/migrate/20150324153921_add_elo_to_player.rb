class AddEloToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :elo, :int
  end
end
