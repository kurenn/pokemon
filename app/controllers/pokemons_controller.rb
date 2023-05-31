class PokemonsController < ApplicationController
  before_action :authenticate_trainer!

  def index
    @pokemons = PokeApi::Pokemon.all(offset:)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def offset
    params[:offset] || 0
  end
end
