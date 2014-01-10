class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :artist
      t.string :song
      t.integer :user_id

      t.timestamps
    end
  end
end
