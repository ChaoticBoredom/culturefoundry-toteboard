Rails.application.routes.draw do
  get "toteboard/index"
  get "toteboard/race_day"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "toteboard#index"
end
