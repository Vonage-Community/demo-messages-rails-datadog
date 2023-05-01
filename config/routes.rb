Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "messages#index"

  post "/message", to: "messages#send_message"
  post "/status", to: "messages#status"
end
