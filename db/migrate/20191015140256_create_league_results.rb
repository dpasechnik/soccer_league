class CreateLeagueResults < ActiveRecord::Migration[6.0]
  def change
    create_table :league_results do |t|
      t.integer :goals_against
      t.integer :goals_for
      t.integer :goals_difference
      t.string :team_name

      t.timestamps
    end
  end
end
