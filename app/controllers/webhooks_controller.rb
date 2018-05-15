class WebhooksController < ApplicationController
  include GithubAccessible

  # POST /webhooks
  # POST /webhooks.json
  def create
    payload_body = request.body.read
    unless verify_signature?(payload_body, request.env['HTTP_X_HUB_SIGNATURE'], Rails.application.secrets.github_webhook_encryption_key)
      raise "Signatures didn't match: #{request.env['HTTP_GITHUB_DELIVERY']}"
    end
    resource = parse_webhook_payload(request.env['HTTP_GITHUB_EVENT'], payload_body)
    unless resource
      raise "Unsupported event detected: #{request.env['HTTP_GITHUB_DELIVERY']}: #{request.env['HTTP_GITHUB_EVENT']}"
    end
    respond_to do |format|
      if resource.save_or_destroy(params[:payload][:action])
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end
end
