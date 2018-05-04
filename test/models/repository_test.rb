require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  test 'should increase count' do
    assert_difference('Repository.count', 1) do
      Repository.import_repositories(
        [
          Repository.new(
            id: 2,
            full_name: 'rancid/life-wont-wait',
            url: 'https://github.com/rancid/rancid/life-wont-wait',
          ),
          Repository.new(
            id: 3,
            full_name: 'rancid/rubysoho',
            url: 'https://github.com/rancid/rubysoho',
          ),
        ]
      )
    end
  end
end
