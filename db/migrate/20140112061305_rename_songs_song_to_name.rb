class RenameSongsSongToName < ActiveRecord::Migration
  def change
    rename_column :songs, :song, :name
  end
end
