module Session
  #
  # UserController is actions for user sessions
  #
  class UsersController < ApplicationController
    include UserSessionable
    include UserAuthenticatable

    before_action :user_authenticate, only: %i[destroy]

    def index; end

    def new
      redirect_to '/auth/google_oauth2'
    end

    def create
      user = User.find_and_update_from_auth_hash(request.env['omniauth.auth'])
      store_user_id(user)
      redirect_to root_path
    end

    def destroy
      delete_user_id
      redirect_to root_path
    end
  end
end
