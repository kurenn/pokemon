class Favorite < ApplicationRecord
  belongs_to :trainer, inverse_of: :favorites

  validates :pokemon_id, presence: true
end
