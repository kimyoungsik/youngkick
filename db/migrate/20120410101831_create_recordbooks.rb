class CreateRecordbooks < ActiveRecord::Migration
  def change
    create_table :recordbooks do |t|
      t.integer :ground_id
      t.integer :user_id
      t.integer :position_id
      t.integer :win, :default => 0
      t.integer :loss, :default => 0
      t.integer :tie, :default => 0            
      t.integer :forwardpoint, :default => 0
      t.integer :midfieldpoint, :default => 0
      t.integer :backpoint, :default => 0
      t.integer :keeperpoint, :default => 0
      t.string :score

      t.timestamps
    end
  end
end
