Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'auctions#index'
  resources :auctions, only: [:new, :show, :index, :create] do
    resources :bids, only: [:create, :destroy]
    resources :publishings, only: :create
    resources :tracks, only: [:create, :destroy]
  end

  resources :users, only:[:new, :create, :show] do
    resources :tracks, only: [:index]
  end
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
  end
end
