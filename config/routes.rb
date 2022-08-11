Rails.application.routes.draw do
  get "/admin" => "admin/homes#top"
  namespace :admin do
    resources :menbers,only:[:index,:update]
  end

  namespace :admin do
    resources :genres,only:[:index,:create,:destroy]
  end

  namespace :admin do
    resources :posts,only:[:index,:show,:destroy]
  end

  root to: "homes#top"
  devise_for :menber,controllers: {
    sessions: "menber/sessions"
  }
  devise_for :admin,skip:[:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }
  devise_scope :admin do
     post '/menbers/guest_sign_in' => 'admin/sessions#guest_log_in'
   end
  resources :menbers,only:[:edit,:update]
  get "/menbers/my_page" => "menbers#show"
  patch "/menbers/withdraw" => "menbers#withdraw"
  resources :posts,only:[:index,:new,:create,:show,:destroy] do
    resources :comments,only:[:create,:destroy]
    resource :favorites,only:[:create,:destroy]
  end
  get 'search' => 'posts#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end