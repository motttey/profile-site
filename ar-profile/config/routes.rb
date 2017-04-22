Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/show/:username' => 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
