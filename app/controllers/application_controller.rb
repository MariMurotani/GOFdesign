class ApplicationController < ActionController::Base
  after_action :flush_logger
  def flush_logger
    @@any_logger.flush_logs
  end
end