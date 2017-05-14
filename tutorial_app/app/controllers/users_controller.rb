class UsersController < ApplicationController
  # 認証機能により権限のないページにアクセスさせないためのbeforeフィルタ
  # コントローラ内のすべてのアクションに適用されるため, :onlyオプションにより:editと:updateのみリダイレクトとする
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  # 別ユーザのバリデーション
  before_action :correct_user,   only: [:edit, :update]
  # 他のアクションからdestroyを適用できない用にする
  before_action :admin_user,     only: :destroy

  def index
    # @users = User.all
    # ページネーションへ対応
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])   # = User.find(1)
    # byebugプロンプトが表示され, ブラウザからconsoleを操作できる
    # debugger
  end
  
  def new
    @user = User.new
  end

  def create
  	# マスアサインメント脆弱性のため無効
    # @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    @user = User.new(user_params)
    if @user.save
      # 保存の成功をここで扱う。
      # flashヘンスウに代入したメッセージは, リダイレクト直後のページで表示できるようになる
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      # 失敗したらnewを表示
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    # before_action :logged_in_userという形式で使う
    def logged_in_user
      unless logged_in?
        # フレンドリーフォワーディングのため現在位置を格納
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      # current_userはsessions_helper内で定義
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

User.new(name: "motttey",email:"motitago@gmail.com",password: "heyhey", password_confirmation: "heyhey")
