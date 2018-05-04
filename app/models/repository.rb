class Repository < ApplicationRecord
  has_many :organization_repositories, dependent: :delete_all
  has_many :organizations, through: :organization_repositories

  #
  # @param [Array<Repository>] repos
  #
  def self.import_repositories(repos)
    import(repos, on_duplicate_key_ignore: true)
  end
end
