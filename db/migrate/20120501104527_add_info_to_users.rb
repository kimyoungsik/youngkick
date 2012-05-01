class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_player, :string
    add_column :users, :favorite_club, :string
    add_column :users, :team_name, :string
    add_column :users, :foot, :string
    add_column :users, :address, :string
    
  end
end
