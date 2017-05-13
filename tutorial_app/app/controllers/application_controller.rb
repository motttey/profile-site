class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ApplicationコントローラにSessionヘルパーモジュールをインクルード
  include SessionsHelper
  
  # application#helloで呼び出し
  def hello
    render html: "hello, world!"
  end
end
