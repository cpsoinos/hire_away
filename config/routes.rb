Rails.application.routes.draw do
  root "events#index"
  devise_for :users

  resources :events, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

  resources :venues, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

  resources :positions, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

end
