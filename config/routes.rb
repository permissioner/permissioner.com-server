Rails.application.routes.draw do
  get 'home/index'
  get 'how-it-works', to: 'home#how_it_works'
  get 'documentation', to: 'home#documentation'

  get 'apps', to: 'apps#index'
  get 'apps/new', to: 'apps#new'

  get 'check-verification-status', to: "application#reload"

  post 'signin', to: 'application#signin'
  get 'signout', to: 'application#signout'

  get 'api/:api_version/verify', to: 'apis#verification'
  get 'api/:api_version/cancel-sign-in', to: 'apis#sign_in_cancellation'

  post 'api/:api_version/authenticate', to: 'apis#authenticate_user'

  root 'home#index'

end
