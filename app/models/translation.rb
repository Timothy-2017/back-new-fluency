class Translation < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites
  belongs_to :word
  belongs_to :language 
end
