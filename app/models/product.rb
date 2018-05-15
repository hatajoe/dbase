class Product < ApplicationRecord
  belongs_to :organization
  has_one :repository, primary_key: :repository_name, foreign_key: :full_name

  scope :find_by_organization, -> (org) { where(organization_id: org.id) }
end
