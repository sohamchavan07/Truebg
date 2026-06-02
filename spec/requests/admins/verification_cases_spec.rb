require 'rails_helper'

RSpec.describe "Admins::VerificationCases", type: :request do
  let(:admin) { Admin.create!(email: "admin@example.com", password: "password123") }
  let(:organization) { Organization.create!(name: "Test Org") }
  let(:candidate) { Candidate.create!(email: "candidate@example.com", password: "password123") }
  let!(:verification_case) { VerificationCase.create!(candidate: candidate, organization: organization, status: "sent") }

  before { sign_in admin, scope: :admin }

  describe "GET /admins/verification_cases" do
    it "returns http success" do
      get admins_verification_cases_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("candidate@example.com")
    end
  end

  describe "GET /admins/verification_cases/:id" do
    it "returns http success" do
      get admins_verification_case_path(verification_case)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Case ##{verification_case.id}")
    end
  end

  describe "PATCH /admins/verification_cases/:id" do
    it "updates the status" do
      patch admins_verification_case_path(verification_case), params: { verification_case: { status: "completed" } }
      expect(response).to redirect_to(admins_verification_case_path(verification_case))
      expect(verification_case.reload.status).to eq("completed")
    end
  end

  describe "POST /admins/verification_cases" do
    it "creates a new verification case and candidate" do
      expect {
        post admins_verification_cases_path, params: { verification_case: { candidate_email: "new@candidate.com", organization_id: organization.id } }
      }.to change(VerificationCase, :count).by(1).and change(Candidate, :count).by(1)
      
      expect(response).to redirect_to(admins_verification_cases_path)
    end
  end
end
