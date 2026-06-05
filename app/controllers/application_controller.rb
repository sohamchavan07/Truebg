class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.is_a?(Candidate)
      if resource.first_name.blank?
        verifications_primary_details_path
      else
        verifications_your_profile_path
      end
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :candidate
      new_candidate_session_path
    else
      super
    end
  end
end
