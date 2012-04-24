class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.has_attached_file :image
      t.references :photoable, :polymorphic => true
      
      t.timestamps
    end
  end
end
