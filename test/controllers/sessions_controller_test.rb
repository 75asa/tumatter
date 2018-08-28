require 'test_helper'

class SessionsConrollerTest < ActionDispatch::IntegrationTest
  
  test "should get new" do
    get login_path
    assert_response :success
  end

end
