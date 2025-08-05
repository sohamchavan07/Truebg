class VerificationsController < ApplicationController
  def phone_verification
    # This action will render the phone_verification view
    render layout: false
  end

  def otp_verification
    # This action will render the otp_verification view
    render layout: false
  end

  def connect_digilocker
    # This action will render the connect_digilocker view
    render layout: false
  end

  def primary_details
    # This action will render the primary_details view
    render layout: false
  end

  def your_profile
    # This action will render the your_profile view
    render layout: false
  end

  def send_otp
    # Get phone number from params
    phone = params[:phone]

    if phone.present?
      # Generate a 5-digit OTP
      otp = rand(10000..99999).to_s

      # Store OTP and phone in session for verification
      session[:otp] = otp
      session[:phone] = phone

      # TODO: Integrate with actual SMS service to send OTP
      # For now, we'll just log it (in production, remove this)
      Rails.logger.info "OTP for #{phone}: #{otp}"

      redirect_to verifications_otp_verification_path, notice: "OTP sent successfully!"
    else
      redirect_to phone_verification_path, alert: "Phone number is required!"
    end
  end

  def verify_otp
    # Get OTP from form fields
    entered_otp = "#{params[:otp_1]}#{params[:otp_2]}#{params[:otp_3]}#{params[:otp_4]}#{params[:otp_5]}"
    stored_otp = session[:otp]

    if stored_otp.present? && entered_otp == stored_otp
      # OTP is correct - clear session and redirect to next step
      session.delete(:otp)
      session[:phone_verified] = true

      # Redirect to connect_digilocker page
      redirect_to verifications_connect_digilocker_path, notice: "Phone number verified successfully!"
    else
      # OTP is incorrect
      redirect_to verifications_otp_verification_path, alert: "Invalid OTP. Please try again."
    end
  end

  def send_welcome_email
    # Get email and name from params
    email = params[:email]
    name = params[:name]

    if email.present?
      begin
        UserMailer.welcome_email(email, name).deliver_now
        flash[:notice] = "Welcome email sent successfully to #{email}!"
      rescue => e
        flash[:error] = "Failed to send welcome email: #{e.message}"
      end
    else
      flash[:error] = "Email address is required"
    end

    redirect_to root_path
  end
end
