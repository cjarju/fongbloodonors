Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # static_pages
  root 'static_pages#home'
  get 'home', to: 'static_pages#home', as: :home
  get 'about', to: 'static_pages#about', as: :about
  get 'contact', to: 'static_pages#contact', as: :contact

  # sessions and users
  get 'signin', to: 'sessions#new', as: :signin
  delete 'signout', to: 'sessions#destroy',  as: :signout

  # blood_donors
  get '/blood_donors/search', to: 'blood_donors#search', as: :search_blood_donor

  # blood_receives
  get '/blood_receivers/search', to: 'blood_receivers#search', as: :search_blood_receiver
  get '/blood_receivers/get_donor', to: 'blood_receivers#get_donor', as: :get_donor
  get '/blood_receivers/show_donor', to: 'blood_receivers#show_donor', as: :show_donor
  get '/blood_receivers/:id/new', to: 'blood_receivers#new', as: :new_blood_receiver

  # users
  get 'signup',  to: 'users#new',  as: :signup
  get '/users/search', to: 'users#search', as: :search_user
  get '/users/:id/edit_password', to: 'users#edit_password', as: :edit_user_password
  match '/users/:id/update_password', to: 'users#update_password', as: :update_user_password, via: [:get, :post]
  get '/users/:id/reset', to: 'users#reset', as: :reset
  match '/users/:id/reset_password', to: 'users#reset_password', as: :reset_user_password, via: [:get, :post]

  # charts
  get '/charts', to: 'charts#dashboard', as: :dashboard

  # resource route creates entries for the actions: index, show, new, create, edit, update, destroy
  resources :blood_donors
  resources :blood_receivers, except: [:new]
  resources :users, except: [:show]
  resources :sessions, only: [:new, :create, :destroy]
end
