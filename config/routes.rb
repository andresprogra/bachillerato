Rails.application.routes.draw do
  devise_for :students, controllers:{
  	omniauth_callbacks: "students/omniauth_callbacks"
  }
  post "/custom_sign_up", to: "students/omniauth_callbacks#custom_sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"
end
