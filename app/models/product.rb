class Product < ApplicationRecord
  belongs_to :organization
  has_one :repository, primary_key: :repository_name, foreign_key: :full_name

  #
  # @param [Organization] organization
  # @return [ActiveRecord::Relation<Product>]
  #
  def self.all_by_organization(organization)
    where(organization_id: organization.id)
  end
end
