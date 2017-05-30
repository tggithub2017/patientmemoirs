require 'test_helper'

class LandpageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get landpage_index_url
    assert_response :success
  end

end
