class Organization < ApplicationRecord
  has_many :organization_users, dependent: :delete_all
  has_many :users, through: :organization_users
  accepts_nested_attributes_for :organization_users
end
