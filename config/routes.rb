Rails.application.routes.draw do

  root to: "homes#top"
  namespace :admin do
    resources :members,only:[:index,:update]
    patch "members/:id/withdraw" => "members#withdraw",as: "member_withdraw"
    resources :genres,only:[:index,:create,:destroy]
    resources :posts,only:[:index,:show]
    delete "/posts/:id" => "posts#destroy",as: "post_delete"
  end

  devise_for :member,controllers: {
    sessions: "member/sessions"
  }

  devise_for :admin,skip:[:passwords],controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_scope :member do
    post "/guest_sign_in" => "member/sessions#guest_sign_in"
  end

  resource :members,only:[:edit,:update] do
    get :like_list
    get :my_page
    get :privacy
    get :terms
    patch :withdraw
  end

  resources :posts,only:[:index,:new,:create,:show] do
    resource :favorites,only:[:create,:destroy]
    resources :comments,only:[:create,:destroy]
  end
  delete "/posts/:id" => "posts#destroy",as: "post_delete"
  get "search" => "posts#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
