Rails.application.routes.draw do
  root "events#index"
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :events, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
