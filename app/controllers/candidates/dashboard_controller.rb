class Candidates::DashboardController < ApplicationController
  before_action :authenticate_candidate!
  layout "candidate_flow"

  def index
    @candidate = current_candidate
    @verification_case = @candidate.verification_cases.last

    if @verification_case&.status == "completed"
      render :completed
    else
      @next_step = determine_next_step
    end
  end

  private

  def determine_next_step
    unless session[:phone_verified]
      return { title: "Phone Verification", path: phone_verification_path, icon: "phone" }
    end

    if @candidate.pan_number.blank?
      return { title: "Identity Proof", path: verifications_connect_digilocker_path, icon: "identification" }
    end

    if @candidate.first_name.blank?
      return { title: "Primary Details", path: verifications_primary_details_path, icon: "user" }
    end

    if @candidate.work_histories.empty?
      return { title: "Work Experience", path: verifications_work_experience_path, icon: "briefcase" }
    end

    if @candidate.education_histories.empty?
      return { title: "Academic History", path: verifications_academic_history_path, icon: "academic-cap" }
    end

    { title: "Final Review", path: verifications_review_profile_path, icon: "clipboard-check" }
  end
end
