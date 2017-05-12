Rails.application.routes.draw do

  get 'users/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#hello'

  # /users/1とかでユーザ情報表示
  # controllerとviewに内容を追記すべき
  #　下の行かくと自動で表7.1のRESTful URIにアプリケーションが対応する
  resources :users

end
