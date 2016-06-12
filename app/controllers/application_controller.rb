class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    store_user_return_to_location
    respond_to_access_denied(exception)
  end

  protected

  def store_user_return_to_location
    session['user_return_to'] = [
      params[:user_return_to],
      request.get? ? request.url : request.referrer,
      session['user_return_to'],
    ].find(&:present?)
  end

  def respond_to_access_denied(_exception)
    if request.format.html? && (!request.xhr?)
      if current_user
        redirect_to root_path, flash: { error: "Sorry, you're not authorized to do that." }
      else
        redirect_to new_user_session_path
      end
    else
      head :unauthorized
    end
  end
end
