require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
  	# beforeフィルタによるRED防ぐために, あらかじめiログインしておく
  	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select "div.alert-danger", "The form contains 4 errors."
  end

  # ユーザの編集に成功するためのテスト
  # ユーザ情報の更新
  # flashメッセージが空でないかどうかと、プロフィールページにリダイレクトされるかどうかをチェック
  # 煩雑さの回避のため, passは空でも更新できるとする

  # successful edit -> successful edit with friendly forwarding

  # フレンドリーフォワーディング
  # 他ユーザからの操作が弾かれた後, 該当ユーザでログインすれば元のページに戻してくれる
  test "successful edit with friendly forwarding" do
  	# beforeフィルタによるRED防ぐために, あらかじめiログインしておく
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
