require 'test_helper'

class ProjectColumnTest < ActiveSupport::TestCase
  setup do
    @payload = Octokit::Client.new.parse_payload(file_fixture('project_column.json').read)
  end

  test 'should increase count' do
    assert_difference('ProjectColumn.count', 1) do
      @payload.id = 1000
      ProjectColumn.from_payload(@payload).save_or_destroy
    end
  end

  test 'should not increase count' do
    assert_difference('ProjectColumn.count', 0) do
      ProjectColumn.from_payload(@payload).save_or_destroy
    end
  end
end
