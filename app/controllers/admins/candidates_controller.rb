class Admins::CandidatesController < Admins::BaseController
  def index
    @candidates = Candidate.all.order(created_at: :desc)
  end

  def show
    @candidate = Candidate.find(params[:id])
    @verification_cases = @candidate.verification_cases.includes(:organization)
    @work_histories = @candidate.work_histories
    @education_histories = @candidate.education_histories
  end
end
