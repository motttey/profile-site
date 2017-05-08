class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # application#helloで呼び出し
  def hello
    render html: "hello, world!"
  end
end
