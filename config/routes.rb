Rails.application.routes.draw do
  get "/admin" => "admin/homes#top"
  namespace :admin do
    resources :menbers,only:[:index,:show,:update]
  end

  namespace :admin do
    resources :genres,only:[:index,:create,:show,:update,:destroy]
  end

  namespace :admin do
    resources :posts,only:[:index,:show,:destroy]
  end

  root to: "homes#top"

  resources :menbers,only:[:show,:edit,:update]
  patch "/menbers/withdraw" => "menbers#withdraw"
  resources :posts,only:[:index,:new,:create,:show,:destroy] do
    resources :comments,only:[:create,:destroy]
    resource :favorites,only:[:create,:destroy]
  end
  devise_for :menbers
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
