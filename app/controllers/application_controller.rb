class ApplicationController < ActionController::Base
  before_action :require_sign_in, :current_competition

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :mobile_device?

  private

  def require_sign_in
    unless current_user
      redirect_to sign_in_url, flash: { return_to: request.fullpath }
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_competition
    @current_competition ||= Competition.find_by(active:true)
  end

  def mobile_device?
    request.user_agent =~ /Mobile/
  end

end
