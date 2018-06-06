class OrganizationUsersController < ApplicationController
  http_basic_authenticate_with name: ENV['USER'], password: ENV['PASS'] if Rails.env.production?

  include UserAuthenticatable

  before_action :user_authenticate

  # POST /organizations
  # POST /organizations.json
  def create
    current_user.organization_users.build(organization_user_params)
    @organization = Organization.find(organization_user_params[:organization_id])
    respond_to do |format|
      if current_user.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { redirect_to @organization, error: 'Organization creation failed.' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_user_params
    params.require(:organization_user).permit(:organization_id, :user_id)
  end
end
