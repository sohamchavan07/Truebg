class Admins::OrganizationsController < Admins::BaseController
  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @verification_cases = @organization.verification_cases.includes(:candidate)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to admins_organizations_path, notice: "Organization created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :email, :phone, :address, :website)
  end
end
