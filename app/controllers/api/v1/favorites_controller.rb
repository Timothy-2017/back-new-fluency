module Api
  module V1
    class FavoritesController < ApplicationController
      def index
        render json: Translation.all
      end
      def create
      end
    end
  end
end
