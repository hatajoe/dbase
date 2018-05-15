require 'test_helper'

class MilestoneTest < ActiveSupport::TestCase
  setup do
    @payload = Octokit::Client.new.parse_payload(file_fixture('milestone.json').read)
  end

  test 'should increase count' do
    assert_difference('Milestone.count', 1) do
      @payload.id = 1000
      m = Milestone.from_payload(@payload)
      m.save_or_destroy
    end
  end

  test 'should not increase count' do
    assert_difference('Milestone.count', 0) do
      Milestone.from_payload(@payload).save_or_destroy
    end
  end

  test 'should decrease count' do
    assert_difference('Milestone.count', -1) do
      Milestone.from_payload(@payload).save_or_destroy(action: 'deleted')
    end
  end
end
