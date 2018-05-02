#
# DashboardController is application entry point actions
#
class DashboardController < ApplicationController
  include UserAuthenticatable

  before_action :user_authenticate

  def index; end
end
