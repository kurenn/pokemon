require 'rails_helper'

RSpec.describe Trainer, type: :model do
  subject { build(:trainer, name: 'Ash') }

  it { is_expected.to validate_presence_of(:name) }
end
