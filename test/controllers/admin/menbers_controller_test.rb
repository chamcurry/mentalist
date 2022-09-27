require "test_helper"

class Admin::MenbersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_menbers_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_menbers_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_menbers_update_url
    assert_response :success
  end

end
