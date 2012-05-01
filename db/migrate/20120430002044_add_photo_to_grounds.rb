class AddPhotoToGrounds < ActiveRecord::Migration
  def change
    add_column :grounds, :photo_file_name, :string
    add_column :grounds, :photo_content_type, :string
    add_column :grounds, :photo_file_size, :integer
    add_column :grounds, :photo_updated_at, :datetime
  end
end
