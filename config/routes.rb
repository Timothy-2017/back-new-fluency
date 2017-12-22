Rails.application.routes.draw do
  resources :favorites
  resources :translations
  # resources :user_words
  # resources :article_words
  # resources :articles_users


  namespace :api do
    namespace :v1 do
      resources :languages
      resources :words
      resources :articles
      resources :users
      resources :translations
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
