class User < ApplicationRecord
  has_many :favorites
  has_many :translations, through: :favorites
end
