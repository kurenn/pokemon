require 'rails_helper'

RSpec.describe Favorite, type: :model do
  subject { build(:favorite) }

  it { is_expected.to validate_presence_of(:pokemon_id) }
  it { is_expected.to belong_to(:trainer).inverse_of(:favorites) }
end
