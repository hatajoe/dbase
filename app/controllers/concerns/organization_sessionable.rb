#
# OrganizationSessionable manipulates the session store about a organization
#
module OrganizationSessionable
  extend ActiveSupport::Concern
  include Sessionable

  #
  # @param [Organization] organization
  #
  def store_organization_id(organization)
    store(:organization_id, organization.id)
  end

  #
  # @return [String]
  #
  def organization_id
    retrieve(:organization_id)
  end

  def delete_organization_id
    delete(:organization_id)
  end
end
