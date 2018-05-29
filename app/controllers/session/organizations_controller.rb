module Session
  class OrganizationsController < ApplicationController
    include UserSessionable
    include OrganizationSessionable
    include OrganizationAuthenticatable

    before_action :organization_authenticate, only: %i[destroy]

    def create
      user = User.find_by(id: user_id)
      organization = user.try(:organizations).try(:find) { |org| org.id == organization_params[:id].to_i }
      if user && organization
        store_organization_id(organization)
        redirect_to organization_path(id: organization.id)
      else
        redirect_to organizations_path
      end
    end

    def destroy
      delete_organization_id
      redirect_to root_path
    end

    private

    def organization_params
      params.require(:organization).permit(:id)
    end
  end
end
