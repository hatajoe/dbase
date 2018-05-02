require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path
    assert_response :redirect
  end

end
