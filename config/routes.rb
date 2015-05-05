Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :events, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

  resources :events, only: [:show] do
    resources :calls do
      resources :availabilities
    end
    resources :offers
    resources :availabilities
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

  resources :calls, only: [:create, :new, :destroy] do
    resources :availabilities
  end

  resources :offers, only: [:create]

  get 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'

end
