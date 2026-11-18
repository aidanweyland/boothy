
Rails.application.routes.draw do
  root "welcome#index"

  get "owner", to: "welcome#owner", as: :owner
  get "vendor", to: "welcome#vendor", as: :vendor

  resources :businesses, only: [:index, :new, :create, :edit, :update] do
    member do
      patch :resize
    end
  end

  resources :booths, only: [:update]

  resources :spaces
end
