Rails.application.routes.draw do

  root to: "homes#top"
  namespace :admin do
    resources :menbers,only:[:index,:update]
    patch 'menbers/:id/withdraw' => 'menbers#withdraw',as: "menber_withdraw"
    resources :genres,only:[:index,:create,:destroy]
    resources :posts,only:[:index,:show]
    delete '/posts/:id' => 'posts#destroy',as: "post_delete"
  end

  devise_for :menber,controllers: {
    sessions: "menber/sessions"
  }

  devise_for :admin,skip:[:passwords],controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_scope :menber do
    post '/guest_sign_in' => 'menber/sessions#guest_sign_in'
  end

  resource :menbers,only:[:edit,:update] do
    get :like_list
    get :my_page
    patch :withdraw
  end

  resources :posts,only:[:index,:new,:create,:show] do
    resource :favorites,only:[:create,:destroy]
    resources :comments,only:[:create,:destroy]
  end
  delete '/posts/:id' => 'posts#destroy',as: "post_delete"
  get 'search' => 'posts#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end