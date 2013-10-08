require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create, session: { email: "john@example.org", password: "hola.123" }
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_redirected_to root_path
  end

end
