class CreateKits < ActiveRecord::Migration
  def change
    create_table :kits do |t|
      t.integer :user_id
      t.text :content
      t.has_attached_file :photo
      t.references :kitable, :polymorphic => true
      t.timestamps
    end
  end
end
