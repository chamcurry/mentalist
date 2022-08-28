Rails.application.routes.draw do

  root to: "homes#top"
  namespace :admin do
    resources :menbers,only:[:index,:update]
    patch 'menbers/:id' => 'menbers#withdraw',as: "menber_withdraw"
    resources :genres,only:[:index,:create,:destroy]
    resources :posts,only:[:index,:show]
    delete '/posts/:id' => 'posts#destroy',as: "post_delete"
  end

  devise_for :menber,controllers: {
    sessions: "menber/sessions"
  }

  devise_for :admin,skip:[:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    post '/menbers/guest_sign_in' => 'admin/sessions#guest_log_in'
  end

  resource :menbers,only:[:edit,:update] do
    get :like_list
    get :my_page
    patch :withdraw
  end
  # patch "/menbers/withdraw" => "menbers#withdraw"
  resources :posts,only:[:index,:new,:create,:show,:destroy] do
    resource :favorites,only:[:create,:destroy]
    resources :comments,only:[:create,:destroy]
  end
  get 'search' => 'posts#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end