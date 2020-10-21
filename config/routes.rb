Rails.application.routes.draw do
  devise_for :users
  resources :events
  resources :users
  root 'events#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
