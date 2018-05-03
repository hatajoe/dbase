class OrganizationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  #
  # @param [User] user
  #
  def self.find_by_user(user)
    where(user_id: user.id)
  end
end
