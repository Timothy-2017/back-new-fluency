# module Api
#   module V1
#     class ArticlesController < ApplicationController
#
#       def index
#         render json: Article.all
#       end
#
#       def create
#         byebug
#         @article = Article.create(description: params[:article], title: params[:title])
#         language = params[:title]
#         text = params[:article]
#         @article.translate
#         render json: @article
#       end
#
#     end
#   end
# end

# module Api
#   module V1
#     class ArticlesController < ApplicationController
#
#       def index
#         render json: Article.all
#       end
#
#       def create
#         # byebug
#         @article = Article.create(description: params[:article], title: params[:title])
#         language = params[:language]
#         text = params[:article]
#         @article.translate(language)
#         render json: @article
#       end
#
#     end
#   end
# end

module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        news_key = ENV["NEWS_API_KEY"]
        news_base_url = "https://newsapi.org/v2/top-headlines?sources=usa-today&apiKey=#{news_key}"
        news_response = HTTParty.get(news_base_url)
        # byebug
        articles = news_response.parsed_response["articles"].slice(0, 1)

        persisted_articles = articles.map do |article|
          # byebug
          Article.find_or_create_by(title: article["title"], description: article["description"])
          # language = params[:language]
          # text = params[:article]
          # @article.translate(language)
          # byebug

          # words = @article.description.split(' ')
          # words.each do |word|
          # #   if params[:language_id] === 1
          # #     language = 'es'
          # #   elsif params[:language_id] === 2
          # #     language = 'fr'
          # #   elsif params[:language_id] === 3
          # #     language = 'de'
          # #   elsif params[:language_id] === 4
          # #     language = 'it'
          # #   else
          # #     language = 'en'
          # #     language_id = 5
          # #   end
          #
          #   word = word.gsub(/[^0-9A-Za-z]/, '')
          #
          #   word_key = ENV["YANDEX_API_KEY"]
          #   word_base_url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{word_key}&lang=en-#{language}&text="
          #   word_url = word_base_url + word
          #   word_response = HTTParty.get(word_url)
          #
          #   if word_response.parsed_response["def"].length === 0
          #     newWord = Word.find_or_create_by(text: word)
          #   else
          #     newWord = Word.find_or_create_by(text: word, pos: word_response.parsed_response["def"][0]["pos"])
          #     # byebug
          #     newTranslation = Translation.find_or_create_by(text: word_response.parsed_response["def"][0]["tr"][0]["text"], language_id: language_id, word_id: newWord.id)
          #   end
          #
          # end
          # render json: @article
        end
        # all_articles = Artical.all
        # three_articles = Artical.all.slice(0, 3)
        # three_articles = three_articles.sort(function(a, b) {
        #   return b.id - a.id;
        # })
        render json: persisted_articles
      end

      # news_response.parsed_response["articles"][0]["title"]

      def create
        #
        # news_key = ENV["NEWS_API_KEY"]
        # news_base_url = "https://newsapi.org/v2/top-headlines?sources=usa-today&apiKey=#{news_key}"
        # news_response = HTTParty.get(news_base_url)
        # # byebug
        # news_response.parsed_response["articles"].each do |article|
        #   # byebug
        #   @article = Article.create(title: article["title"], description: article["description"])
          # language = params[:language]
          # text = params[:article]
          # @article.translate(language)
          # byebug
          # render json: @article
        # end
      end

    end
  end
end
