class Project < ApplicationRecord
  include GithubResourceable

  has_one :repository, primary_key: :repository_name, foreign_key: :full_name
  has_many :project_columns, dependent: :destroy

  #
  # @param [Sawyer::Resource] payload
  # @return [Project]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      repository_name: resource_reponame(payload.owner_url),
      number: payload.number,
      owner_url: payload.owner_url,
      html_url: payload.html_url,
      state: payload.state,
      name: payload.name,
      body: payload.body,
    )
  end
end
