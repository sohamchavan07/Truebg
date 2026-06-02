class Admins::VerificationCasesController < Admins::BaseController
  def index
    @verification_cases = VerificationCase.all.includes(:candidate, :organization).order(created_at: :desc)
  end

  def show
    @verification_case = VerificationCase.find(params[:id])
  end

  def update
    @verification_case = VerificationCase.find(params[:id])
    if @verification_case.update(verification_case_params)
      redirect_to admins_verification_case_path(@verification_case), notice: "Status updated successfully!"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def new
    @verification_case = VerificationCase.new
    @organizations = Organization.all
  end

  def create
    email = params[:verification_case][:candidate_email]
    candidate = Candidate.find_or_initialize_by(email: email)

    if candidate.new_record?
      # Set a random password for new candidates
      candidate.password = SecureRandom.hex(8)
      candidate.save!
    end

    @verification_case = VerificationCase.new(verification_case_params)
    @verification_case.candidate = candidate
    @verification_case.status = "sent"
    @verification_case.requested_at = Time.current

    if @verification_case.save
      # In a real app, we would send an invitation email here
      # VerificationMailer.invitation(@verification_case).deliver_later
      redirect_to admins_verification_cases_path, notice: "Verification case created and invitation sent!"
    else
      @organizations = Organization.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def verification_case_params
    params.require(:verification_case).permit(:organization_id, :status)
  end
end
