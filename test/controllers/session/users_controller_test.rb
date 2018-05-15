require 'test_helper'

class Session::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:userone)
  end

  test 'should get index' do
    get session_users_url
    assert_response :success
  end

  test 'should get new' do
    get new_session_user_url
    assert_response :redirect
  end

  test 'should destroy session_user' do
    delete session_user_url(@user)
    assert_response :redirect
  end
end
