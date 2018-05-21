class Issue < ApplicationRecord
  include GithubResourceable

  #
  # @param [Sawyer::Resource] payload
  # @return [Issue]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      repository_name: resource_reponame(payload.repository_url),
      milestone_id: payload.milestone.try(:id) || 0,
      number: payload.number,
      repository_url: payload.repository_url,
      html_url: payload.html_url,
      state: payload.state,
      title: payload.title,
      body: payload.body
    )
  end
end
