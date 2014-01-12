class RenameSubmissionsToSongs < ActiveRecord::Migration
  def change
    rename_table :submissions, :songs
  end
end
