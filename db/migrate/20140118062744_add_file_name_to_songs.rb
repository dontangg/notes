class AddFileNameToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :file_name, :string
  end
end
