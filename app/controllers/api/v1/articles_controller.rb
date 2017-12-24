module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        news_key = ENV["NEWS_API_KEY"]
        news_base_url = "https://newsapi.org/v2/top-headlines?sources=usa-today&apiKey=#{news_key}"
        news_response = HTTParty.get(news_base_url)
        articles = news_response.parsed_response["articles"].slice(0, 1)

        persisted_articles = articles.map do |article|
          Article.find_or_create_by(title: article["title"], description: article["description"])
        end

        render json: persisted_articles
      end

      def create

      end

    end
  end
end

# module Api
#   module V1
#     class ArticlesController < ApplicationController
#
#       def index
#         self.create
#         render json: Article.all
#       end
#
#       def create
#         news_key = ENV["NEWS_API_KEY"]
#         news_base_url = "https://newsapi.org/v2/top-headlines?sources=usa-today&apiKey=#{news_key}"
#         news_response = HTTParty.get(news_base_url)
#         articles = news_response.parsed_response["articles"].slice(0, 1)
#
#         persisted_articles = articles.map do |article|
#           Article.find_or_create_by(title: article["title"], description: article["description"])
#         end
#
#         render json: persisted_articles[0]
#       end
#
#     end
#   end
# end
