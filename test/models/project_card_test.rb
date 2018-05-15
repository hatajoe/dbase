require 'test_helper'

class ProjectCardTest < ActiveSupport::TestCase
  setup do
    @payload = Octokit::Client.new.parse_payload(file_fixture('project_card.json').read)
  end

  test 'should increase count' do
    assert_difference('ProjectCard.count', 1) do
      @payload.id = 1000
      ProjectCard.from_payload(@payload).save_or_destroy
    end
  end

  test 'should not increase count' do
    assert_difference('ProjectCard.count', 0) do
      ProjectCard.from_payload(@payload).save_or_destroy
    end
  end
end
