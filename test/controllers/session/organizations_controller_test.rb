require 'test_helper'

class Session::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:one)
  end

  test 'should create session_organization' do
    post session_organizations_url('test')
    assert_response :redirect
  end

  test 'should destroy session_organization' do
    delete session_organization_url(@organization)
    assert_response :redirect
  end
end
