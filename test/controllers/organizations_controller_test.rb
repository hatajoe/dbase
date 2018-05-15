require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:orgone)
  end

  test 'should get index' do
    get organizations_url
    assert_response :redirect
  end

  test 'should not get new when not signed in' do
    get new_organization_url
    assert_response :redirect
  end

  test 'should not create organization when not signed in' do
    post organizations_url, params: { organization: { name: 'Sakanaction', uid: 'sakanaction' } }
    assert_response :redirect
  end

  test 'should show organization when not signed in' do
    get organization_url(@organization)
    assert_response :redirect
  end

  test 'should not get edit when not sined in' do
    get edit_organization_url(@organization)
    assert_response :redirect
  end

  test 'should update organization' do
    patch organization_url(@organization), params: { organization: { name: @organization.name, uid: @organization.uid } }
    assert_response :redirect
  end

  test 'should not destroy organization when not sined in' do
    assert_difference('Organization.count', 0) do
      delete organization_url(@organization)
    end

    assert_redirected_to :session_users
  end
end
