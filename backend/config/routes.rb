Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cars, param: :id, only: %i[create update index]
end
