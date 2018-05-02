Rails.application.config.middleware.use OmniAuth::Builder do
  client_id = Rails.application.secrets.google_app_client_id
  client_secret = Rails.application.secrets.google_app_client_secret
  provider :google_oauth2, client_id, client_secret
end
