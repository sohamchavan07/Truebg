require 'rails_helper'

RSpec.describe "Admins::VerificationCases", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admins/verification_cases/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admins/verification_cases/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admins/verification_cases/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admins/verification_cases/create"
      expect(response).to have_http_status(:success)
    end
  end
end
