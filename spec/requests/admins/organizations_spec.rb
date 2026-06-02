require 'rails_helper'

RSpec.describe "Admins::Organizations", type: :request do
  let(:admin) { Admin.create!(email: "admin@example.com", password: "password123") }
  let!(:organization) { Organization.create!(name: "Test Org", email: "test@org.com") }

  before { sign_in admin, scope: :admin }

  describe "GET /admins/organizations" do
    it "returns http success" do
      get admins_organizations_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Org")
    end
  end

  describe "GET /admins/organizations/:id" do
    it "returns http success" do
      get admins_organization_path(organization)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Org")
    end
  end

  describe "POST /admins/organizations" do
    it "creates a new organization" do
      expect {
        post admins_organizations_path, params: { organization: { name: "New Org", email: "new@org.com" } }
      }.to change(Organization, :count).by(1)
      expect(response).to redirect_to(admins_organizations_path)
    end
  end
end
