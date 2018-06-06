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

  #
  # @param [Product] key_product
  # @return [Array<Milestone]
  #
  def milestones_by_product(key_product)
    select_product_by(key_product).map { |product| product.repository.milestones }.flatten
  end

  #
  # @param [Product] product
  # @param [Milestone] milestone
  # @return [Array<ProjectCard>]
  #
  def project_cards_by_product_and_milestone(product, milestone)
    project_cards_by_product(product).select do |card|
      milestone.blank? || card.belongs_to?(milestone)
    end
  end

  private

  #
  # @param [Product] key_product
  # @return [Array<ProjectCard>]
  #
  def project_cards_by_product(key_product)
    project_cards = select_product_by(key_product).map do |product|
      product.repository.projects.map do |project|
        project.project_columns.map do |column|
          column.project_cards
        end
      end
    end
    project_cards.flatten
  end

  #
  # @param [Product] product
  # @return [Product]
  #
  def select_product_by(product)
    products.select { |p| product.blank? || p.id == product.id }
  end
end
