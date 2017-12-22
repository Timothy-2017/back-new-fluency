module Api
  module V1
    class UsersController < ApplicationController

      def index
        render json: User.all
      end

      def create
      end
    end
  end
end
