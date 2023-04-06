class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  #新規登録時（sign_up時)にnameというキーのパラメーターを追加で許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit( :sign_up, keys: [:name] )
  end

  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  # #ログアウト後のリダイレクト先
  # def after_sign_out_path_for(resource)
  #   root_path
  # end
end
