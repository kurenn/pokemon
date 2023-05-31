class PokemonsController < ApplicationController
  before_action :authenticate_trainer!

  def index
    @pokemons = if params[:search].present?
                  PokeApi::Pokemon.search(params[:search])
                else
                  PokeApi::Pokemon.all(offset:)
                end

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
