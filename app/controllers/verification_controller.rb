class VerificationsController < ApplicationController
    def phone_verification
    end
  
    def otp_verification
    end
  
    def send_otp
      # TODO: Add OTP generation and sending logic here
      redirect_to verifications_otp_verification_path
    end
  end