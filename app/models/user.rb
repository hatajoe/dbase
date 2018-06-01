  class User < ApplicationRecord
  has_many :organization_users, dependent: :delete_all
  has_many :organizations, through: :organization_users
  has_many :repositories, through: :organizations

  #
  # @param [Object] auth
  # @return [User]
  #
  def self.find_and_update_from_auth_hash(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |u|
      u.update!(
        provider: auth.provider,
        uid: auth.uid,
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        email: auth.info.email,
        picture: auth.info.image
      )
    end
  end

  #
  # @return [String]
  #
  def full_name
    "#{first_name} #{last_name}"
  end

  #
  # @param [Organization]
  # @return [TrueClass or FalseClass]
  #
  def belongs_to?(organization)
    !!organizations.find { |belong| belong.uid == organization.uid }
  end
end
