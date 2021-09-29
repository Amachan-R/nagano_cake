Rails.application.routes.draw do
  devise_for :admin, controllers: {
        sessions: 'admin/sessions'
      }

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#index'
    get '/customers/my_page' => 'customers#show'
    get '/customers/edit' => 'customers#edit'
    patch '/customers' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
  end

  devise_for :customers, controllers: {
        sessions: 'public/sessions',
        registrations: 'public/registrations',
        passwords: 'public/passwords'
      }


  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    get '' => 'homes#top'
    resources :order_details, only: [:update]
  end


end
