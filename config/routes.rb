# frozen_string_literal: true
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'pages/index'
  
  concern :likeable do
    resources :likes, only: [:create]
  end

  concern :replyable do
    resources :replies, only: [:create]
  end

  concern :reportable do
    resources :reports, only: [:create]
  end
#Allow all requests from frontend for article to proceed
#resources means by seven built-in methods::new,create,update,destroy,edit,index,show
#from articles  it will specify the request type like it is POST so that it will be for create
  resources :articles, concerns: %i[likeable reportable], shallow: true do
    resources :comments, only: [:create]
    resources :suggestions, only: %i[create destroy]
  end
  resources :suggestions, only: %i[index create destroy], concerns: [:replyable]
  resources :comments, only: [:create], concerns: %i[likeable reportable replyable]
#define the pages index of view
  root 'pages#index'
  resources :pages, only: %i[index edit]
  resources :likes, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
