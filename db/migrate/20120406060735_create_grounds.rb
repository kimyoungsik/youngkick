class CreateGrounds < ActiveRecord::Migration
  def change
    create_table :grounds do |t|
      t.integer :user_id
      t.string :title
      t.string :location
      t.datetime :datetime
      t.text :description
      t.integer :forwardcount
      t.integer :midfieldcount
      t.integer :backcount
      t.integer :keepercount
      t.string :status, :default => 'pending'
      t.string :score
      t.string :winner
      t.integer :limit
      t.integer :limitday
      
      t.timestamps
    end
  end
end
