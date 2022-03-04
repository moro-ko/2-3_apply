class ApplicationController < ActionController::Base
  # アクセス権限の設定(ログイン認証が成功していないと指定のページ以外は表示できないよう設定:21章)
  before_action :authenticate_user!, except: [:top, :about]

  # deviseのストロングパラメーターの設定
  # deviseの機能(ユーザー登録、ログイン認証)が使われる前にconfigure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    # root_path
    current_user
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
