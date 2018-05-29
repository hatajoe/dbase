#
# OrganizationsController manipulates organization resources
#
class OrganizationsController < ApplicationController
  include UserAuthenticatable
  include OrganizationAuthenticatable
  include GithubAccessible

  before_action :user_authenticate
  before_action :organization_authenticate, only: %i(show edit update destroy)
  before_action :set_organization, only: %i(show edit update destroy)

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = OrganizationUser.includes(:organization).find_by_user(@current_user).map(&:organization)
    redirect_to new_organization_path if @organizations.blank?
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show; end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit; end

  # POST /organizations
  # POST /organizations.json
  def create
    repositories = repos(organization_params[:github_api_token])
    Repository.import_repositories(repositories)
    @organization = current_user.organizations.build(organization_params).tap do |o|
      o.try(:build_organization_repositories, repositories)
    end
    respond_to do |format|
      if current_user.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = @current_organization || Organization.find_by(id: params[:id])
    redirect_to organizations_path if @organization.blank?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:uid, :name, :github_api_token)
  end
end
