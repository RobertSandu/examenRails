class ApplicationController < ActionController::Base

before_action :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :este_administrator

  def este_administrator
  	current_user.tip_utilizator == 1
  end


end
