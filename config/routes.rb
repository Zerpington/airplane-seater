Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'app#home'

  namespace :api do
    post 'plan_seat' => 'seat#plan_seat'
  end
end
