module Api
  module V1
    class FavoritesController < ApplicationController

      def index
        favorites_array = []
        favorites = Favorite.all

        favorites.map do |favorite|
          translated = Translation.find(favorite.translation_id)
          word = Word.find(translated.word_id)
          user = User.find(favorite.user_id)
          favorites_array.push({ word: word.text, translated: translated.text, user_id: user.id, id: favorite.id, note: favorite.note})
        end

        render json: favorites_array
      end

      def create
        # byebug
        translation = Translation.find_by(text: params[:translatedWord])
        newFavorite = Favorite.create(user_id: params[:user_id], translation_id: translation.id)
        render json: newFavorite
      end

      def show
        render json: Favorite.find(params[:id])
      end

      def destroy
        favorite = Favorite.find(params[:id])
        favorite.destroy
      end

      def edit
        favorite = Favorite.find(params[:id])
      end

      def update
        # byebug
        favorite = Favorite.find(params[:id])
        favorite.update(note: params[:note])

        render json: favorite
      end
    end
  end
end
