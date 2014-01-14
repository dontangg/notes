class AddExtensionToSong < ActiveRecord::Migration
  def change
    add_column :songs, :extension, :string
  end
end
