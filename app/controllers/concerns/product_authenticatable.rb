module ProductAuthenticatable
  extend ActiveSupport::Concern
  include ProductSessionable

  included do
    helper_method :current_product
  end

  def product_authenticate
    redirect_to session_products_path unless product_signed_in?
  end

  #
  # @return [Product]
  #
  def current_product
    @current_product ||= Product.find_by(id: product_id)
  end

  private

  def product_signed_in?
    current_product.present?
  end
end