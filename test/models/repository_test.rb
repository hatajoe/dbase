require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  setup do
    @payload = Octokit::Client.new.parse_payload(file_fixture('repository.json').read)
  end

  test 'should increase count' do
    assert_difference('Repository.count', 1) do
      @payload.id = 1000
      payload = Repository.from_payload(@payload)
      Repository.import_repositories([payload])
    end
  end

  test 'should not increase count' do
    assert_difference('Repository.count', 0) do
      payload = Repository.from_payload(@payload)
      Repository.import_repositories([payload])
    end
  end
end
