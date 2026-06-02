Rails.application.routes.draw do
  devise_for :admins
  get "home/index"

  devise_for :candidates, controllers: {
    sessions: "candidate/sessions",
    registrations: "candidate/registrations",
    passwords: "candidate/passwords"
  }


  root "home#index"

  # Admin dashboard
  namespace :admins do
    root "dashboard#index"
    get "dashboard", to: "dashboard#index"
    resources :organizations
    resources :verification_cases
    resources :candidates, only: [ :index, :show ]
  end

  # Phone verification flow
  get "phone_verification", to: "verifications#phone_verification"
  post "send_otp", to: "verifications#send_otp", as: :verifications_send_otp
  get "otp_verification", to: "verifications#otp_verification", as: :verifications_otp_verification
  post "verify_otp", to: "verifications#verify_otp", as: :verifications_verify_otp
  get "connect_digilocker", to: "verifications#connect_digilocker", as: :verifications_connect_digilocker
  get "primary_details", to: "verifications#primary_details", as: :verifications_primary_details
  patch "update_primary_details", to: "verifications#update_primary_details", as: :verifications_update_primary_details
  get "verifications/your_profile", to: "verifications#your_profile", as: :verifications_your_profile
  post "add_work_history", to: "verifications#add_work_history", as: :verifications_add_work_history
  post "add_education_history", to: "verifications#add_education_history", as: :verifications_add_education_history
  post "submit_verification", to: "verifications#submit_verification", as: :verifications_submit_verification

  # Welcome email functionality
  post "send_welcome_email", to: "verifications#send_welcome_email", as: :send_welcome_email
end
