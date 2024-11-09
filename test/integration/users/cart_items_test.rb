require "test_helper"
require_relative "./integration_test"

class Users::CartItemsTest < Users::IntegrationTest
  test "show cart" do
    get cart_items_path
    assert_response :success
    assert_select "h1", "カート"
  end

  test "create and destroy cart item" do
    product = products(:product1)
    assert_changes -> { @user.cart_items.count }, 1 do
      post cart_items_path(product_id: product.id)
    end
    assert @user.cart_items.exists?(product_id: product.id)

    assert_changes -> { @user.cart_items.count }, -1 do
      delete cart_item_path(@user.cart_items.first)
    end
    assert_not @user.cart_items.exists?(product_id: product.id)
  end

  test "increment and decrement cart item" do
    product = products(:product1)
    assert_changes -> { @user.cart_items.count }, 1 do
      post cart_items_path(product_id: product.id)
    end

    assert_changes -> { @user.cart_items.first.quantity }, 1 do
      patch increment_cart_item_path(@user.cart_items.first)
    end

    assert_changes -> { @user.cart_items.first.quantity }, -1 do
      patch decrement_cart_item_path(@user.cart_items.first)
    end
  end

  test "show cart with charge" do
  end
end
