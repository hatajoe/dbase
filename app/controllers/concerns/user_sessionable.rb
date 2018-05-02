#
# UserSessionable manipulates the session store about a user
#
module UserSessionable
  extend ActiveSupport::Concern
  include Sessionable

  #
  # @param [User] user
  #
  def store_user_id(user)
    store(:user_id, user.id)
  end

  #
  # @return [String]
  #
  def user_id
    retrieve(:user_id)
  end

  def delete_user_id
    delete(:user_id)
  end
end
