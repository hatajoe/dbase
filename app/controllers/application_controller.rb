class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['USER'], password: ENV['PASS'] if Rails.env.production?
end
