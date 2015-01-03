class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.boolean :active

      t.timestamps
    end

    add_column :attempts, :competition_id, :integer
    add_column :songs, :competition_id, :integer

    comp = Competition.create
    Attempt.update_all competition_id: comp.id
    Song.update_all competition_id: comp.id

  end
end
