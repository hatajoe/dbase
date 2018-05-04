class OrganizationRepository < ApplicationRecord
  belongs_to :organization
  belongs_to :repository
end
