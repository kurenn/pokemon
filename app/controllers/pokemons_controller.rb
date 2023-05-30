class PokemonsController < ApplicationController
  before_action :authenticate_trainer!

  def index
    @pokemons = PokeApi::Pokemon.all(offset:)
  end

  private

  def offset
    params[:offset] || 0
  end
end
