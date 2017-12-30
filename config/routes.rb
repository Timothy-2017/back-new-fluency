Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :languages
      resources :words
      resources :articles
      resources :users
      resources :translations
      resources :favorites
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
