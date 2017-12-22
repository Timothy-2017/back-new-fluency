class Article < ApplicationRecord

  def translate(language)
    # byebug
    text = self.description
    key = ENV["YANDEX_API_KEY"]
    # language = self.title
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
