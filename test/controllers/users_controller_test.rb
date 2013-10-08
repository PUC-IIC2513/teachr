require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:john)
    @new_user = User.new(
      first_name: 'Nuevo',
      last_name: 'Usuario',
      email: 'nuevo_usuario@example.org',
      password: 'hola.123',
      role: 'student'
    )
    
    session[:user_id] = users(:john).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: @new_user.email, first_name: @new_user.first_name, last_name: @new_user.last_name, password: @new_user.password, password_confirmation: @new_user.password, role: @new_user.role }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password, role: @user.role }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
