Rails.application.routes.draw do
  get "home/index"

  devise_for :candidates, controllers: {
    sessions: "candidate/sessions",
    registrations: "candidate/registrations",
    passwords: "candidate/passwords"
  }

  root "home#index"

  # Phone verification flow
  get "phone_verification", to: "verifications#phone_verification"
  post "send_otp", to: "verifications#send_otp", as: :verifications_send_otp
  get "otp_verification", to: "verifications#otp_verification", as: :verifications_otp_verification
  post "verify_otp", to: "verifications#verify_otp", as: :verifications_verify_otp
  get "connect_digilocker", to: "verifications#connect_digilocker", as: :verifications_connect_digilocker
  get "primary_details", to: "verifications#primary_details", as: :verifications_primary_details

  # Welcome email functionality
  post "send_welcome_email", to: "verifications#send_welcome_email", as: :send_welcome_email
end
