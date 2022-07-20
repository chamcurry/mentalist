Rails.application.routes.draw do
  namespace :admin do
    resources :menbers,only:[:index,:show,:update]
  end

  namespace :admin do
    resources :genres,only:[:index,:create,:show,:update,:destroy]
  end

  namespace :admin do
    resources :posts,only:[:index,:show,:destroy]
  end

  namespace :admin do
    get 'homes/top'
  end

  devise_for :menbers
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
