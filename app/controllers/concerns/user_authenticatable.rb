module UserAuthenticatable
  extend ActiveSupport::Concern
  include UserSessionable

  included do
    helper_method :current_user
  end

  def user_authenticate
    redirect_to session_users_path unless user_signed_in?
  end

  #
  # @return [User]
  #
  def current_user
    @current_user ||= User.find_by(id: user_id)
  end

  private

  def user_signed_in?
    current_user.present?
  end
end
