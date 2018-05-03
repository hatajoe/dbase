class User < ApplicationRecord
  has_many :organization_users
  has_many :organizations, through: :organization_users

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
end
