require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should increase count' do
    assert_difference('User.count', 1) do
      User.find_and_update_from_auth_hash(
        OpenStruct.new(
          provider: 'google_oauth2',
          uid: '300000000000000000000',
          info: OpenStruct.new(
            first_name: 'Ichiro',
            last_name: 'Yamaguchi',
            email: 'ichiro@yamaguchi.com',
            picture: ''
          )
        )
      )
    end
  end

end
