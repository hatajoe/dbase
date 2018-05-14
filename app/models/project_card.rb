class ProjectCard < GithubResource
  belongs_to :project_column
  has_one :issue, primary_key: :issue_id, foreign_key: :number

  #
  # @param [Sawyer::Resource] payload
  # @return [Proc]
  #
  def self.from_payload(payload)
    case payload.action
    when 'deleted' then
      -> { find_or_initialize_by(id: payload.id).try(:destroy_all) }
    else
      -> {
        find_or_initialize_by_resource(
          payload,
          issue_id: response.content_url.try(:split, '/').try(:last).to_i,
          project_column_id: column.id,
          note: response.note,
          content_url: response.content_url
        ).save
      }
    end
  end

  #
  # @param [Sawyer::Resource] response
  # @param [ProjectColumn] column
  # @return [ProjectCard]
  #
  def self.from_response(response, column)
    find_or_initialize_by_resource(
      response,
      id: response.id,
      issue_id: response.content_url.try(:split, '/').try(:last).to_i,
      project_column_id: column.id,
      note: response.note,
      content_url: response.content_url
    )
  end

  #
  # @return [String]
  #
  def note
    (issue.try(:title) || read_attribute(:note)).to_s
  end
end
