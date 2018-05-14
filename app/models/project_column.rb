class ProjectColumn < GithubResource
  belongs_to :project
  has_many :project_cards, dependent: :destroy

  #
  # @param [Sawyer::Resource] payload
  # @return [ProjectColumn]
  #
  def self.from_payload(payload)
    case payload.action
    when 'deleted' then
      -> { find_or_initialize_by(id: payload.id).try(:destroy_all) }
    else
      -> {
        find_or_initialize_by_resource(
          payload,
          name: payload.name
        ).save
      }
    end
  end

  #
  # @param [Sawyer::Resource] response
  # @param [Project] project
  # @return [ProjectColumn]
  #
  def self.from_response(response, project)
    find_or_initialize_by_resource(
      response,
      id: response.id,
      project_id: project.id,
      name: response.name
    )
  end
end
