FactoryBot.define do
  factory :league_result do
    transient do
      sequence :n
    end

    team_name { "Awesome team name #{n}" }
    goals_against { 45 }
    goals_for { 55 }
    goals_difference { 10 }
  end
end