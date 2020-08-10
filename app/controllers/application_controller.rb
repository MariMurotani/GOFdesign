class ApplicationController < ActionController::Base
  after_action :flush_logger

  def initialize
    @account = nil
  end

  def flush_logger
    @@any_logger.flush_logs
  end

  def authenticate_user
    true if params["token"].present? && params["token"] == session[:token]
    raise 'Authentication Error'
  end

  def auth_user(controller_name)
    @account = Account.where({name: params[:name]}).last
    if params["password"].present? && @account.password == params["password"]
      Encoding.default_internal = "UTF-8"
      token = Digest::MD5.hexdigest(controller_name)
      session[:token] = token.to_s
    else
      raise 'Authentication Error'
    end
  end
end