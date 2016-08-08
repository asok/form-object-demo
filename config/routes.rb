Rails.application.routes.draw do
  resource :quick_registration, only: [:new, :create]
  resource :full_registration, only: [:new, :create]
end
