require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test 'should increase count' do
    assert_difference('OrganizationRepository.count', 2) do
      organization = Organization.new(uid: 'test', name: 'test', github_api_token: 'test')
      organization.build_organization_repositories(Repository.find(1, 2))
      organization.organization_repositories.map(&:save)
    end
  end
end
