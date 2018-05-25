class ProjectCard < ApplicationRecord
  include GithubResourceable

  belongs_to :project_column
  has_one :issue, primary_key: :issue_id, foreign_key: :number

  #
  # @param [Sawyer::Resource] payload
  # @return [ProjectCard]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      issue_id: resource_id(payload.content_url),
      project_column_id: resource_id(payload.column_url),
      note: payload.note,
      column_url: payload.column_url,
      content_url: payload.content_url
    )
  end

  #
  # @return [String]
  #
  def note
    (issue.try(:title) || read_attribute(:note)).to_s
  end

  #
  # @param [Integer] milestone_id
  # @return [TrueClass or FalseClass]
  #
  def belongs_to?(milestone_id)
    issue.blank? || issue.try(:milestone).try(:id) == milestone_id
  end
end
