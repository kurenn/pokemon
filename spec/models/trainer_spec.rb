require 'rails_helper'

RSpec.describe Trainer, type: :model do
  subject { build(:trainer, name: 'Ash') }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:favorites).dependent(:destroy).inverse_of(:trainer) }

  describe '#initials' do
    context 'when the name is simple' do
      let(:trainer) { build(:trainer, name: 'Ash') }

      it 'returns the initials of the trainer' do
        expect(trainer.initials).to eq('A')
      end
    end

    context 'when the name is complex' do
      let(:trainer) { build(:trainer, name: 'Ash ketchum') }

      it 'returns the initials of the trainer' do
        expect(trainer.initials).to eq('AK')
      end
    end
  end
end
