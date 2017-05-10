require 'test_helper'

class SegssionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get segssions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get segssions_destroy_url
    assert_response :success
  end

end
