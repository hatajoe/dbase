require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @payload = Octokit::Client.new.parse_payload(file_fixture('project.json').read)
  end

  test 'should increase count' do
    assert_difference('Project.count', 1) do
      @payload.id = 1000
      Project.from_payload(@payload).save_or_destroy
    end
  end

  test 'should not increase count' do
    assert_difference('Project.count', 0) do
      Project.from_payload(@payload).save_or_destroy
    end
  end
end
