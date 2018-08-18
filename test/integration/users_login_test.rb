require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nKent)
  end

  test "login with invalid information" do
    # ログイン用のパスを開く
    get login_path
    # 新規セッションのフォームが正しく表示されていることを確認
    assert_template 'sessions/new'
    # わざと無効なparamハッシュを利用しセッション用パスにPOST
    post login_path, params: { session: { email: "", password: "" } }
    # 新規セッションのフォームが再度表示され、フラッシュメッセージが追加されることを確認
    assert_template 'sessions/new'
    assert_not flash.empty?
    # 別のページ（Homeページ）に一旦移動
    get root_path
    # 移動さきのページでフラッシュメッセージが表示されていないことを確認
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                              password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                            password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
