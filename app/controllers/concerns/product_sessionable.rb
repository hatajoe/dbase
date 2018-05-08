#
# ProductSessionable manipulates the session store about a product
#
module ProductSessionable
  extend ActiveSupport::Concern
  include Sessionable

  #
  # @param [Product] product
  #
  def store_product_id(product)
    store(:product_id, product.id)
  end

  #
  # @return [String]
  #
  def product_id
    retrieve(:product_id)
  end

  def delete_product_id
    delete(:product_id)
  end
end
