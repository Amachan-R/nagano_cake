Rails.application.routes.draw do
  devise_for :admin, controllers: {
        sessions: 'admin/sessions'
      }

  #devise_for :customers, controllers: {
    #sessions: 'public/sessions'
    #registrations: 'public/registrations'
    #passwords: 'public/passwords'
  #}

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    get '' => 'homes#top'
    #patch
  end

  scope module: :public do
    root to: 'homes#top'
  end

end
