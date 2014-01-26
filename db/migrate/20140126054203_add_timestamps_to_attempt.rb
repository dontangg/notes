class AddTimestampsToAttempt < ActiveRecord::Migration
  def change
    change_table :attempts do |t|
      t.timestamps
    end
  end
end
