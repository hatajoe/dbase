require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:repoone)
  end

  test "should get index" do
    get repositories_url
    assert_response :redirect
  end
end
