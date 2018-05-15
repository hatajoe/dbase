class Issue < ApplicationRecord
  include GithubResourceable

  belongs_to :milestone

  #
  # @param [Sawyer::Resource] payload
  # @return [Proc]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      milestone_id: payload.milestone.try(:id),
      number: payload.number,
      html_url: payload.html_url,
      state: payload.state,
      title: payload.title,
      body: payload.body
    )
  end
end
