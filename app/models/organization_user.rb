class OrganizationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  scope :find_by_user, -> (user) { where(user_id: user.id) }
end
