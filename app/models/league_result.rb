class LeagueResult < ApplicationRecord

  validates :team_name, length: { in: 1..250 }, presence: true
  validates :goals_against, numericality: { only_integer: true }
  validates :goals_for, numericality: { only_integer: true }
  validates :goals_difference, numericality: { only_integer: true }

end
