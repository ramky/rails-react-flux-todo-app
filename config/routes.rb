Rails.application.routes.draw do
  resources :todos, only: [:index, :show, :create, :destroy]
  root 'todos#index'

  put    "update_completed/:id" => 'todos#update_completed'
  put    "update_name/:id" => 'todos#update_name'
  delete "clear_completed" => 'todos#clear_completed'
end
