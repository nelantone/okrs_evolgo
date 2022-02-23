Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'users/:id/create_goal', to: 'users#create_goal'
  post 'users/:id/goals/:id/create_goal_key_result', to: 'users#create_goal_key_result'
end
