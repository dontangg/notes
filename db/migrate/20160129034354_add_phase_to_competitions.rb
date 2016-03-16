class AddPhaseToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :phase, :integer, default: 0
  end
end
