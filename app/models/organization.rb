class Organization < ApplicationRecord
  has_many :organization_users, dependent: :delete_all
  has_many :users, through: :organization_users
  has_many :organization_repositories, dependent: :delete_all
  has_many :repositories, through: :organization_repositories
  has_many :products, dependent: :delete_all

  attribute :github_api_token

  attr_encrypted :github_api_token, key: :encryption_key

  #
  # @param [Array<Repository>] repos
  #
  def build_organization_repositories(repos)
    repos.each do |r|
      organization_repositories.build(
        organization_id: id,
        repository_id: r.id
      )
    end
  end

  #
  # @return [String]
  #
  def encryption_key
    Rails.application.secrets.github_api_token_encryption_key
  end
end
