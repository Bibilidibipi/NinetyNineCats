NinetyNineCats::Application.routes.draw do
  root to: "cats#index"

  resources :cats
  resources :cat_rental_requests, only: [:create, :new] do
    member do
      post 'approve'
      post 'deny'
    end
  end
end
