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
  # @return [Task]
  #
  def task
    @t ||= Task.new(issue.body) if issue.present?
  end

  #
  # @param [Milestone] milestone
  # @return [TrueClass or FalseClass]
  #
  def belongs_to?(milestone)
    return false if project_column.project.repository_name != milestone.repository_name
    issue.blank? || issue.try(:milestone).try(:id) == milestone.id
  end
end
