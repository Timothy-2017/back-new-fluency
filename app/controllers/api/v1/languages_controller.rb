module Api
  module V1
    class LanguagesController < ApplicationController
      def index
        render json: Language.all
      end
      def create
      end
    end
  end
end
