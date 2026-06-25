class VerificationsController < ApplicationController
  before_action :authenticate_candidate!, except: [ :start, :consent, :submit_consent, :phone_verification, :send_otp, :otp_verification, :verify_otp ]
  skip_before_action :verify_authenticity_token, only: [ :send_otp, :verify_otp, :submit_verification ]

  layout "candidate_flow"
  before_action :set_verification_case
  before_action :check_if_completed, except: [ :start, :consent, :submit_consent, :thank_you, :review_profile ]
  before_action :check_consent, except: [ :start, :consent, :submit_consent ]

  def set_verification_case
    @verification_case = current_candidate&.verification_cases&.last
  end

  def check_if_completed
    if @verification_case&.status == "completed"
      redirect_to candidate_dashboard_path, alert: "Your profile is already submitted and locked for evaluation."
    end
  end

  def check_consent
    if @verification_case && !@verification_case.consent_given?
      redirect_to verifications_consent_path
    end
  end

  def start
    @verification_case = VerificationCase.find_by!(token: params[:token])
    session[:verification_case_id] = @verification_case.id

    # Automatically sign in the candidate associated with this case
    if @verification_case.candidate
      sign_in(@verification_case.candidate)
      @verification_case.update(status: "in_progress") if @verification_case.status == "sent"
    end

    if @verification_case.consent_given?
      redirect_to phone_verification_path
    else
      redirect_to verifications_consent_path
    end
  end

  def consent
    # Renders the consent view
  end

  def submit_consent
    if params[:consent_given] == "1" && params[:signature_text].present?
      @verification_case.update!(
        consent_given: true,
        consent_given_at: Time.current,
        consent_ip_address: request.remote_ip,
        signature_text: params[:signature_text]
      )
      redirect_to phone_verification_path, notice: "Thank you for providing your consent."
    else
      flash.now[:alert] = "You must agree to the terms and provide a digital signature to proceed."
      render :consent, status: :unprocessable_entity
    end
  end

  def phone_verification
  end

  def otp_verification
  end

  def connect_digilocker
  end

  def thank_you
  end

  def primary_details
    @candidate = current_candidate
  end

  def update_primary_details
    if current_candidate.update(candidate_params)
      redirect_to verifications_work_experience_path, notice: "Primary details saved successfully!"
    else
      render :primary_details, status: :unprocessable_entity
    end
  end

  def work_experience
    @candidate = current_candidate
    @work_histories = current_candidate.work_histories
  end

  def academic_history
    @candidate = current_candidate
    @education_histories = current_candidate.education_histories
  end

  def review_profile
    @candidate = current_candidate
    @work_histories = current_candidate.work_histories
    @education_histories = current_candidate.education_histories
  end

  def add_work_history
    @work_history = current_candidate.work_histories.build(work_history_params)
    if @work_history.save
      redirect_to verifications_work_experience_path, notice: "Work history added!"
    else
      redirect_to verifications_work_experience_path, alert: "Failed to add work history."
    end
  end

  def add_education_history
    @education_history = current_candidate.education_histories.build(education_history_params)
    if @education_history.save
      redirect_to verifications_academic_history_path, notice: "Education history added!"
    else
      redirect_to verifications_academic_history_path, alert: "Failed to add education history."
    end
  end

  def submit_verification
    # Here we would update the VerificationCase status
    verification_case = current_candidate.verification_cases.where(status: [ "in_progress", "sent" ]).last
    if verification_case
      verification_case.update(status: "completed", completed_at: Time.current)
      redirect_to verifications_thank_you_path, notice: "Verification submitted for review!"
    else
      redirect_to verifications_review_profile_path, alert: "You've already submitted your profile or no active case was found."
    end
  end

  def send_otp
    phone = params[:phone]
    if phone.present?
      otp = "12345" # Using static OTP for testing as requested
      session[:otp] = otp
      session[:phone] = phone

      # In development, we log the OTP for the user to see
      Rails.logger.info "\n\n" + ("=" * 40)
      Rails.logger.info "SECURITY ALERT: OTP for #{phone} is: #{otp}"
      Rails.logger.info ("=" * 40) + "\n\n"

      redirect_to verifications_otp_verification_path, notice: "OTP sent to +91 #{phone}!"
    else
      redirect_to phone_verification_path, alert: "Please enter a valid mobile number."
    end
  end

  def verify_otp
    entered_otp = "#{params[:otp_1]}#{params[:otp_2]}#{params[:otp_3]}#{params[:otp_4]}#{params[:otp_5]}"
    stored_otp = session[:otp]

    if (stored_otp.present? && entered_otp == stored_otp) || entered_otp == "12345"
      session.delete(:otp)
      session[:phone_verified] = true

      # Save the verified phone number to the candidate record
      if current_candidate && session[:phone].present?
        current_candidate.update(phone: session[:phone])
      end

      redirect_to verifications_connect_digilocker_path, notice: "Phone number verified successfully!"
    else
      redirect_to verifications_otp_verification_path, alert: "Invalid OTP. Please try again."
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :dob, :pan_number, :aadhaar_number, :address, :city, :state, :pincode)
  end

  def work_history_params
    params.require(:work_history).permit(:company_name, :job_title, :start_date, :end_date, :current_job, :location)
  end

  def education_history_params
    params.require(:education_history).permit(:institution_name, :degree, :field_of_study, :graduation_year)
  end
end
