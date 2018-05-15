class Repository < ApplicationRecord
  include GithubResourceable

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
  # @return [Repository]
  #
  def self.from_payload(payload)
    find_or_initialize_by_resource(
      payload,
      id: payload.id,
      full_name: payload.full_name,
      html_url: payload.html_url,
      state: payload.state
    )
  end
end
