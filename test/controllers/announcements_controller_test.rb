require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase
  setup do
    @announcement = announcements(:i1)
    @new_announcement = Announcement.new(
      title: "Testing",
      content: "Testing announcements...",
      level: 1,
      notify: false,
      user: users(:john)
    )
    
    session[:user_id] = users(:john).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:announcements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create announcement" do
    assert_difference('Announcement.count') do
      post :create, announcement: { content: @new_announcement.content, level: @new_announcement.level, notify: @new_announcement.notify, title: @new_announcement.title, user_id: @new_announcement.user_id }
    end

    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should show announcement" do
    get :show, id: @announcement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @announcement
    assert_response :success
  end

  test "should update announcement" do
    patch :update, id: @announcement, announcement: { content: @announcement.content, level: @announcement.level, notify: @announcement.notify, title: @announcement.title, user_id: @announcement.user_id }
    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should destroy announcement" do
    assert_difference('Announcement.count', -1) do
      delete :destroy, id: @announcement
    end

    assert_redirected_to announcements_path
  end
end
