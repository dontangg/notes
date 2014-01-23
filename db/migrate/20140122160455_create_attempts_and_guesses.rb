class CreateAttemptsAndGuesses < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :correct_count
    end

    create_table :guesses do |t|
      t.integer :attempt_id
      t.integer :song_id
      t.integer :user_id
    end
  end
end
