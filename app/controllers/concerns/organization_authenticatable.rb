module OrganizationAuthenticatable
  extend ActiveSupport::Concern
  include OrganizationSessionable

  included do
    helper_method :current_organization
  end

  def organization_authenticate
    redirect_to organizations_path unless organization_signed_in?
  end

  def current_organization
    @current_organization ||= Organization.find_by(id: organization_id)
  end

  private

  def organization_signed_in?
    current_organization.present?
  end
end
