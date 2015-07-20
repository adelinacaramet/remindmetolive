require 'rack-mini-profiler'

class ApplicationController < ActionController::Base

  before_filter :authorize

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # A hook in your ApplicationController
  def authorize
    #if current_user.is_admin?
      Rack::MiniProfiler.authorize_request
    #end
  end
end
