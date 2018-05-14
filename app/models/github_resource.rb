class GithubResource < ApplicationRecord
  self.abstract_class = true

  #
  # @param [Sawyer::Resource] payload
  # @param [Hash] attributes
  # @return [GithubResource]
  #
  def self.find_or_initialize_by_resource(resource, attributes)
    find_or_initialize_by(id: resource.id).tap { |model| model.assign_attributes(attributes) }
  end
end