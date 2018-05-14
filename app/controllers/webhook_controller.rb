class WebhookController < ApplicationController
  # PATCH/PUT /webhook/1.json
  def update
    unless verify_signature?(request.body.read, request.env['HTTP_X_HUB_SIGNATURE'], Rails.application.secrets.github_webhook_encryption_key)
      raise "Signatures didn't match: #{request.env['HTTP_GITHUB_DELIVERY']}"
    end
    resolver = parse_webhook(request.env['HTTP_GITHUB_EVENT'], params['payload'])
    unless resolver
      raise "Unsupported event detected: #{request.env['HTTP_GITHUB_DELIVERY']}: #{request.env['HTTP_GITHUB_EVENT']}"
    end
    respond_to do |format|
      if resolver.call
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end
end
