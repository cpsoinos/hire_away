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
    :destroy,
    :venues_select
  ]

  resources :events, only: [:show] do
    resources :calls
    resources :offers
  end

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

  resources :calls
  resources :offers

  get 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'

end
