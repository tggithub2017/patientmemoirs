require 'test_helper'

class DashboardpageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboardpage_index_url
    assert_response :success
  end

end
