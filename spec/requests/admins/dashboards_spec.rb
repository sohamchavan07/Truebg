require 'rails_helper'

RSpec.describe "Admins::Dashboards", type: :request do
  let(:admin) { Admin.create!(email: "admin@example.com", password: "password123") }

  describe "GET /admins/dashboard" do
    context "when admin is logged in" do
      before do
        sign_in admin, scope: :admin
      end

      it "returns http success" do
        get admins_dashboard_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Admin Dashboard")
      end
    end

    context "when admin is not logged in" do
      it "redirects to sign in page" do
        get admins_dashboard_path
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
