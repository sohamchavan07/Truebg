require 'rails_helper'

RSpec.describe "Admins::Candidates", type: :request do
  let(:admin) { Admin.create!(email: "admin@example.com", password: "password123") }
  let!(:candidate) { Candidate.create!(email: "candidate@example.com", password: "password123", first_name: "John", last_name: "Doe") }

  before { sign_in admin, scope: :admin }

  describe "GET /admins/candidates" do
    it "returns http success" do
      get admins_candidates_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("John Doe")
    end
  end

  describe "GET /admins/candidates/:id" do
    it "returns http success" do
      get admins_candidate_path(candidate)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("John Doe")
      expect(response.body).to include("candidate@example.com")
    end
  end
end
