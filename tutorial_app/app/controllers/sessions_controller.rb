class SessionsController < ApplicationController
  def create
  	# メールアドレスを持つユーザーがデータベースに存在し、
  	#   かつ入力されたパスワードがそのユーザーのパスワードである場合のみ、if文がtrueになる
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # log_inはヘルパー内で定義
      log_in user
      # rememberチェックボックス
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user # (= user_url(user))
    else
      # エラーメッセージを作成する
      # flash.nowのメッセージはその後リクエストが発生したときに消滅, flashはきえない
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def new

  end

  def destroy
    log_out if logged_in?
     # ログアウトしたらトップに戻る
    redirect_to root_url
  end
end
