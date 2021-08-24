Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # TODO: group routes using scope?
  get "/insights/summaries", to: "insights#index"
  get "/insights/dailyconversions/:user_id", to: "insights#daily_conversions_by_user_id"
end
