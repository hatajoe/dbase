class RepositoriesController < ApplicationController
  include UserAuthenticatable
  include OrganizationAuthenticatable

  before_action :user_authenticate
  before_action :organization_authenticate

  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = @current_organization.repositories
  end
end
