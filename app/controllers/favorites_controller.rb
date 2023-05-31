class FavoritesController < ApplicationController
  before_action :authenticate_trainer!

  def index
    @pokemons = current_trainer.favorites.map do |favorite|
      PokeApi::Pokemon.find(favorite.pokemon_id)
    end
  end

  def create
    @favorite = current_trainer.favorites.find_or_create_by(favorite_params)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @favorite = current_trainer.favorites.find_by(favorite_params)
    @favorite.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:pokemon_id)
  end
end
