require "test_helper"

class VentasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ventas_index_url
    assert_response :success
  end

  test "should get new" do
    get ventas_new_url
    assert_response :success
  end

  test "should get create" do
    get ventas_create_url
    assert_response :success
  end

  test "should get cancel" do
    get ventas_cancel_url
    assert_response :success
  end
end
