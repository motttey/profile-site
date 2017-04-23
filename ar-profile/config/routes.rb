Rails.application.routes.draw do
  get 'users/edit'
  get 'users/update'
  get 'users/index'
  get 'users/show'
  get 'users/show/:username' => 'users#show'
  get 'users/edit/:username' => 'users#edit'
  post 'users/edit/:username' => 'users#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
