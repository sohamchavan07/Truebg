require 'rails_helper'

RSpec.describe "Admins::Organizations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admins/organizations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admins/organizations/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admins/organizations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admins/organizations/create"
      expect(response).to have_http_status(:success)
    end
  end
end
