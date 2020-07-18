Rails.application.routes.draw do
  root to: "owners#index"

  get "/machines/:id", to: 'machines#show'

  get "/snacks/:id", to: 'snacks#show'

  get "/owners", to: 'owners#index'
end
