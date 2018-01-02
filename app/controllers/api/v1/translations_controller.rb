module Api
  module V1
    class TranslationsController < ApplicationController

      def index
        render json: Translation.all
      end

      def create
        if (params[:language_id]).to_i === 5
          # byebug
          render json: {translated_article: params[:english_article][:description]}
        else
          # byebug
          article = params["english_article"]
          words_array = article.split(' ')
          # article = Article.find_by(id: params[:english_article]["id"])
          # words_array = article.description.split(' ')
          word_key = ENV["YANDEX_API_KEY"]
          language = Language.find_by(id: params[:language_id])
          word_base_url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{word_key}&lang=en-#{language.code}&text="

          translated_article = words_array.map do |word|
            # byebug
            word = word.gsub(/[^0-9A-Za-z]/, '').downcase
            database_word = Word.find_by(text: word)

            if database_word
              translation = database_word.translations.find_by(language_id: language.id)
            else
              translations = false
            end




            if database_word && translation
              translation.text
            else
              word_response = HTTParty.get(word_base_url + word)
              if word_response.parsed_response['def'].length > 0
                database_word = Word.find_or_create_by(text: word, pos: word_response.parsed_response["def"][0]["pos"])

                translated_word = word_response.parsed_response["def"][0]["tr"][0]["text"]
                newTranslation = database_word.translations.create(language_id: language.id, text: translated_word)

                newTranslation.text
              else
                # this is the scenario where the api does not have data on this word
                # lets just set the translation to be itself
                unfound_word = Word.create(text: word, pos: 'unavailable')
                unfound_word.translations.create(language_id: language.id, text: word)
                word
              end
            end

          end
          render json: {translated_article: translated_article.join(" ")}
        end
      end
    end
  end
end


# module Api
#   module V1
#     class TranslationsController < ApplicationController
#
#       def index
#         render json: Translation.all
#       end
#
#       def create
#         if (params[:language_id]).to_i === 5
#           # byebug
#           render json: {translated_article: params[:english_article][:description]}
#         else
#           # byebug
#           article = Article.find_by(id: params[:english_article]["id"])
#           words_array = article.description.split(' ')
#           word_key = ENV["YANDEX_API_KEY"]
#           language = Language.find_by(id: params[:language_id])
#           word_base_url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{word_key}&lang=en-#{language.code}&text="
#
#           translated_article = words_array.map do |word|
#             # byebug
#             word = word.gsub(/[^0-9A-Za-z]/, '')
#             word_url = word_base_url + word
#             word_response = HTTParty.get(word_url)
#
#             if !(word_response.parsed_response["def"].length === 0)
#               newWord = Word.find_or_create_by(text: word, pos: word_response.parsed_response["def"][0]["pos"])
#               translated_word = word_response.parsed_response["def"][0]["tr"][0]["text"]
#               newTranslation = Translation.find_or_create_by(text: translated_word, language_id: language.id, word_id: newWord.id)
#               newTranslation.text
#             else
#               word
#             end
#           end
#           render json: {translated_article: translated_article.join(" ")}
#         end
#       end
#     end
#   end
# end
