class Article < ApplicationRecord
  # has_many :articles_users
  # has_many :users, through: :articles_users
  # has_many :article_words
  # has_many :articles, through: :article_words

  def translate
    # byebug
    text = self.description
    key = ENV["YANDEX_API_KEY"]
    language = self.title
    base_url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{key}&lang=en-#{language}&text="

    translated_article = []

    words = text.split(' ')
    # byebug
    words.each do |word|
      # byebug
      newWord = word.downcase

      if newWord[newWord.length - 1] === 's'
        newWord = newWord.slice(0, newWord.length - 1)
      end

      url = base_url + newWord
      response = HTTParty.get(url)
      # byebug
      if response.parsed_response["def"].length === 0
        translated_article.push(word)
      elsif response.parsed_response["def"][0]["pos"] === 'noun'
        translated_article.push(response.parsed_response["def"][0]["tr"][0]["text"])
      else
        translated_article.push(word)
      end
    end

    self.description = translated_article.join(' ')
    self.save
  end
end
##########################
module Api
  module V1
    class ArticlesController < ApplicationController

      def show
        render json: Article.last
      end

      def index
        render json: Article.all
      end

      def create
        @article = Article.create(description: params[:article], title: params[:title])
        language = params[:title]
        text = params[:article]
        @article.translate
        render json: @article
      end

      def edit

      end

      def update

      end

      def destroy

      end

      # private
      #
      # def article_params
      #   params.require(:article).permit(:text)
      # end
    end
  end
end
