class Milestone < ApplicationRecord
  include GithubResourceable

  has_many :issues

  #
  # @param [Sawyer::Resource] payload
  # @return [Milestone]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      repository_name: milestone_reponame(payload.html_url),
      number: payload.number,
      title: payload.title,
      description: payload.description,
      html_url: payload.html_url,
      state: payload.state,
      open_issues: payload.open_issues,
      closed_issues: payload.closed_issues,
      due_on: payload.due_on
    )
  end

  #
  # @return [Integer]
  #
  def progress
    len = issues.length
    return 0 if len == 0
    ((closed_issues.to_f / len.to_f) * 100).to_i
  end
end
