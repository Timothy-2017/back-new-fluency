module Api
  module V1
    class WordsController < ApplicationController

      def index
        render json: Word.all
      end

      def create
      end
    end
  end
end
