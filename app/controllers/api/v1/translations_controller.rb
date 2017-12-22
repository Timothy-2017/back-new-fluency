module Api
  module V1
    class TranslationsController < ApplicationController
      def index
        render json: Translation.all
      end
      def create

        article = Article.find_by(id: params[:display_article_id])
        words_array = article.description.split(' ')
        word_key = ENV["YANDEX_API_KEY"]
        language = Language.find_by(id: params[:language_id])

        translated_article = words_array.map do |word|
          # byebug
          word = word.gsub(/[^0-9A-Za-z]/, '')
          word_base_url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{word_key}&lang=en-#{language.code}&text="
          word_url = word_base_url + word
          word_response = HTTParty.get(word_url)

          if !(word_response.parsed_response["def"].length === 0)
            newWord = Word.find_or_create_by(text: word, pos: word_response.parsed_response["def"][0]["pos"])
            translated_word = word_response.parsed_response["def"][0]["tr"][0]["text"]
            # byebug
            newTranslation = Translation.find_or_create_by(text: translated_word, language_id: language.id, word_id: newWord.id)
            newTranslation.text
          else
            word
          end
        end


        
        render json: {translated_article: translated_article.join(" ")}

      end
    end
  end
end
