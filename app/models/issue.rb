class Issue < ApplicationRecord
  include GithubResourceable

  belongs_to :milestone, optional: true

  #
  # @param [Sawyer::Resource] payload
  # @return [Issue]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      repository_name: resource_reponame(payload.repository_url),
      milestone_id: payload.milestone.try(:id),
      number: payload.number,
      repository_url: payload.repository_url,
      html_url: payload.html_url,
      state: payload.state,
      title: payload.title,
      body: payload.body
    )
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def opened?
    state == 'open'
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def closed?
    state == 'closed'
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def issue?
    html_url.split('/')[-2] == 'issues'
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def pull_request?
    html_url.split('/')[-2] == 'pull'
  end
end
