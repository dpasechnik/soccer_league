require 'rails_helper'

RSpec.describe ImportDataService do
  let(:file_name) { 'football_test_data.dat' }

  let(:instance) { described_class.new(file_name) }

  before :each do
    expect(instance).to receive(:file_path)
      .at_least(:once)
      .and_return(File.join('spec', 'support', 'test_data', file_name))
  end

  subject { instance.perform }

  describe '#perform' do
    context 'when error' do
      context 'when file with `file_name` doesn\'t exist' do
        let(:file_name) { 'babushka' }

        it 'raises an exception' do
          expect { subject }.to raise_error(described_class::Error::NoFile, /Unable to find file `#{file_name}` in `lib\/data`/)
        end
      end
    end

    context 'when success' do
      it 'generally works' do
        expect{ subject }.to change(LeagueResult, :count).from(0).to(7)
      end
    end
  end
end