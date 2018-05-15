class ProjectColumn < ApplicationRecord
  include GithubResourceable

  belongs_to :project
  has_many :project_cards, dependent: :destroy

  #
  # @param [Sawyer::Resource] payload
  # @return [ProjectColumn]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      project_id: resource_id(payload.project_url),
      project_url: payload.project_url,
      name: payload.name
    )
  end
end
