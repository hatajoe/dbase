class Repository < GithubResource
  has_many :organization_repositories, dependent: :delete_all
  has_many :organizations, through: :organization_repositories
  has_many :milestones, dependent: :delete_all
  has_many :projects, dependent: :delete_all

  #
  # @param [Array<Repository>] repos
  #
  def self.import_repositories(repos)
    import(repos, on_duplicate_key_ignore: true)
  end

  #
  # @param [Sawyer::Resource] payload
  # @return [Proc]
  #
  def self.from_payload(payload)
    -> {
      find_or_initialize_by_resource(
        payload,
        state: payload.state,
      ).save
    }
  end

  #
  # @param [Sawyer::Resource] response
  # @return [Repository]
  #
  def self.from_response(response)
    find_or_initialize_by_resource(
      response,
      id: response.id,
      full_name: response.full_name,
      url: response.html_url,
      state: response.state
    )
  end
end
