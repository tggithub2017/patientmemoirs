require 'test_helper'

class SetssionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get setssions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get setssions_destroy_url
    assert_response :success
  end

end
