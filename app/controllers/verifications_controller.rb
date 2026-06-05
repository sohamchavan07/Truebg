class VerificationsController < ApplicationController
  before_action :authenticate_candidate!, except: [ :start, :phone_verification, :send_otp, :otp_verification, :verify_otp ]

  layout "candidate_flow"

  def start
    @verification_case = VerificationCase.find_by!(token: params[:token])
    session[:verification_case_id] = @verification_case.id
    redirect_to phone_verification_path
  end

  def phone_verification
  end

  def otp_verification
  end

  def connect_digilocker
  end

  def primary_details
    @candidate = current_candidate
  end

  def update_primary_details
    if current_candidate.update(candidate_params)
      redirect_to verifications_your_profile_path, notice: "Primary details updated successfully!"
    else
      render :primary_details, status: :unprocessable_entity
    end
  end

  def your_profile
    @candidate = current_candidate
    @work_histories = current_candidate.work_histories
    @education_histories = current_candidate.education_histories
  end


  def add_work_history
    @work_history = current_candidate.work_histories.build(work_history_params)
    if @work_history.save
      redirect_to verifications_your_profile_path, notice: "Work history added!"
    else
      redirect_to verifications_your_profile_path, alert: "Failed to add work history."
    end
  end

  def add_education_history
    @education_history = current_candidate.education_histories.build(education_history_params)
    if @education_history.save
      redirect_to verifications_your_profile_path, notice: "Education history added!"
    else
      redirect_to verifications_your_profile_path, alert: "Failed to add education history."
    end
  end

  def submit_verification
    # Here we would update the VerificationCase status
    verification_case = current_candidate.verification_cases.where(status: "in_progress").last
    if verification_case
      verification_case.update(status: "completed", completed_at: Time.current)
      redirect_to root_path, notice: "Verification submitted for review!"
    else
      redirect_to root_path, alert: "No active verification case found."
    end
  end

  def send_otp
    phone = params[:phone]
    if phone.present?
      otp = rand(10000..99999).to_s
      session[:otp] = otp
      session[:phone] = phone
      Rails.logger.info "OTP for #{phone}: #{otp}"
      redirect_to verifications_otp_verification_path, notice: "OTP sent successfully!"
    else
      redirect_to phone_verification_path, alert: "Phone number is required!"
    end
  end

  def verify_otp
    entered_otp = "#{params[:otp_1]}#{params[:otp_2]}#{params[:otp_3]}#{params[:otp_4]}#{params[:otp_5]}"
    stored_otp = session[:otp]

    if stored_otp.present? && entered_otp == stored_otp
      session.delete(:otp)
      session[:phone_verified] = true

      # For now, if no candidate is logged in, we might need to handle registration or login
      # In a real flow, the invitation token would link to a candidate
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
