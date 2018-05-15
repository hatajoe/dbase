require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:productone)
  end

  test "should get index" do
    get products_url
    assert_response :redirect
  end

  test "should get new" do
    get new_product_url
    assert_response :redirect
  end

  test "should create product" do
    assert_difference('Product.count', 0) do
      post products_url, params: { product: { name: @product.name, organization_id: @product.organization_id, repository_id: @product.repository_name } }
    end

    assert_redirected_to session_users_path
  end

  test "should show product" do
    get product_url(@product)
    assert_response :redirect
  end

  test "should update product" do
    patch product_url(@product), params: { product: { name: @product.name, organization_id: @product.organization_id, repository_id: @product.repository_name } }
    assert_redirected_to session_users_path
  end

  test "should destroy product" do
    assert_difference('Product.count', 0) do
      delete product_url(@product)
    end

    assert_redirected_to session_users_path
  end
end
