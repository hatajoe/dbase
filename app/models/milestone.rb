class Milestone < GithubResource
  belongs_to :repository
  has_many :issues, dependent: :destroy

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
          title: payload.title,
          description: payload.description,
          state: response.state,
          open_issues: payload.open_issues,
          closed_issues: payload.closed_issues,
          due_on: payload.due_on
        ).save
      }
    end
  end

  #
  # @param [Sawyer::Resource] response
  # @param [Repository] repository
  # @return [Milestone]
  #
  def self.from_response(response, repository)
    find_or_initialize_by_resource(
      response,
      id: response.id,
      repository_id: repository.id,
      number: response.number,
      title: response.title,
      description: response.description,
      url: response.html_url,
      state: response.state,
      open_issues: response.open_issues,
      closed_issues: response.closed_issues,
      due_on: response.due_on
    )
  end
end
