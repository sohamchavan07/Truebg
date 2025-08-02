Rails.application.routes.draw do
  get "home/index"
  get "verifications/phone_verification"
  get 'verifications/otp_verification', to: 'verifications#otp_verification'


  devise_for :candidates, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  root 'home#index'

  # Phone verification page
  get 'phone_verification', to: 'verifications#phone_verification'
  post 'send_otp', to: 'verifications#send_otp', as: :verifications_send_otp
end