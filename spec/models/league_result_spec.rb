require 'rails_helper'

RSpec.describe LeagueResult, type: :model do
  it_behaves_like 'model with a factory'

  describe 'validations' do
    it { is_expected.to validate_presence_of(:team_name) }
    it { is_expected.to validate_length_of(:team_name).is_at_least(1).is_at_most(250) }

    it { is_expected.to validate_numericality_of(:goals_against) }
    it { is_expected.to validate_numericality_of(:goals_for) }
    it { is_expected.to validate_numericality_of(:goals_difference) }
  end
end
