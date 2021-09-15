Rails.application.routes.draw do
  devise_for :admin, controllers: {
        sessions: 'admin/sessions'
      }

  devise_for :customers

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  #root to: 'homes/top'
end
