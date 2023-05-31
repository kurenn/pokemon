class PokemonCardComponent < ViewComponent::Base
  delegate :current_trainer, to: :helpers

  def initialize(pokemon)
    @pokemon = pokemon
  end

  def favorited?
    !favorite.new_record?
  end

  def favorite
    @favorite ||= (current_trainer.favorites.find_by(pokemon_id: @pokemon.id) || Favorite.new)
  end
end
