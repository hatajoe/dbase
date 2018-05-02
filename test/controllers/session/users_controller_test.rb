require 'test_helper'

class Session::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session_user = session_users(:one)
  end

  test "should get index" do
    get session_users_url
    assert_response :success
  end

  test "should get new" do
    get new_session_user_url
    assert_response :success
  end

  test "should create session_user" do
    assert_difference('Session::User.count') do
      post session_users_url, params: { session_user: {  } }
    end

    assert_redirected_to session_user_url(Session::User.last)
  end

  test "should destroy session_user" do
    assert_difference('Session::User.count', -1) do
      delete session_user_url(@session_user)
    end

    assert_redirected_to session_users_url
  end
end
