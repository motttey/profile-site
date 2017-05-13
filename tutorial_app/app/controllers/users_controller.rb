class UsersController < ApplicationController
  

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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

User.new(name: "motttey",email:"motitago@gmail.com",password: "heyhey", password_confirmation: "heyhey")
