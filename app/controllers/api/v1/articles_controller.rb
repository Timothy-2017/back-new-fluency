module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        news_key = ENV["NEWS_API_KEY"]
        news_base_url = "https://newsapi.org/v2/top-headlines?sources=usa-today&apiKey=#{news_key}"
        news_response = HTTParty.get(news_base_url)

        # byebug
        # article = news_response.parsed_response["articles"].sample
        # article = article["title"].concat('. ').concat(article["description"])


        article_arr = []
        articles = news_response.parsed_response["articles"]
        articles.map do |article|
          article_text = article["title"].concat('. ').concat(article["description"])
          article_url = article["urlToImage"]
          article_arr.push({article_text: article_text, article_url: article_url})
        end
        # byebug
        render json: article_arr

        # articles = news_response.parsed_response["articles"].slice(0, 1)
        # persisted_articles = articles.map do |article|
        #   Article.find_or_create_by(title: article["title"], description: article["description"])
        # end
        # render json: persisted_articles
      end

      def create

      end

    end
  end
end
