class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #applicationコントローラーでSessionsヘルパーを読み込む事で、どこでもSessionsヘルパーを使えるようになる
  include SessionsHelper
  
  def hello
    render html: "HelloWorld"
  end
end
