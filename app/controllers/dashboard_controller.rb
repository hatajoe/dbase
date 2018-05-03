#
# DashboardController is application entry point actions
#
class DashboardController < ApplicationController
  include UserAuthenticatable
  include OrganizationAuthenticatable

  before_action :user_authenticate
  before_action :organization_authenticate

  def index; end
end
