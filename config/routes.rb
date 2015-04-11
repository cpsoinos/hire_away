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

  # resources :events, only: [
  #   :new,
  #   :update
  # ] do
  #

  resources :venues, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]
end
