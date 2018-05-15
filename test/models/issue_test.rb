require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @payload = Octokit::Client.new.parse_payload(file_fixture('issue.json').read)
  end

  test 'should increase count' do
    assert_difference('Issue.count', 1) do
      @payload.id = 1000
      Issue.from_payload(@payload).save_or_destroy
    end
  end

  test 'should not increase count' do
    assert_difference('Issue.count', 0) do
      Issue.from_payload(@payload).save_or_destroy
    end
  end
end
