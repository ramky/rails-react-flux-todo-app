Rails.application.routes.draw do
  resources :todos
  root 'todos#index'

  delete 'clear_completed' => 'todos#clear_completed'
end
