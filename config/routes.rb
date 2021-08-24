Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # TODO: group routes using scope? or namespace?
  # TODO: version these routes
  get "/insights/summaries", to: "insights#index"
  get "/insights/dailyconversions", to: "insights#get_daily_conversions"
end
