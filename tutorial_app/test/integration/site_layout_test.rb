require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "layout links when loggin success" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    # assert_select "a[href=?]", current_user
    # assert_select "a[href=?]", edit_user_path(current_user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
  end
end
