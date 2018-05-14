class Project < GithubResource
  belongs_to :repository
  has_many :project_columns, dependent: :destroy

  #
  # @param [Sawyer::Resource] payload
  # @return [Project]
  #
  def self.from_payload(payload)
    case payload.action
    when 'deleted' then
      -> { find_or_initialize_by(id: payload.id).try(:delete_all) }
    else
      -> {
        find_or_initialize_by_resource(
          payload,
          state: payload.state,
          name: payload.name,
          body: payload.body
        ).save
      }
    end
  end

  #
  # @param [Sawyer::Resource] response
  # @param [Repository] repository
  # @return [Project]
  #
  def self.from_response(response, repository)
    find_or_initialize_by_resource(
      response,
      id: response.id,
      repository_id: repository.id,
      number: response.number,
      url: response.html_url,
      state: response.state,
      name: response.name,
      body: response.body,
    )
  end
end
