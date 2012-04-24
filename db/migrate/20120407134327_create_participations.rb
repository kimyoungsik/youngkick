class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :ground_id
      t.integer :position_id
      t.integer :team_id

      t.timestamps
    end
  end
end
