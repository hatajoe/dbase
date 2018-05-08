class Repository < ApplicationRecord
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
end
