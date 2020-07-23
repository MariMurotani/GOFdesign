class ApplicationController < ActionController::Base
  after_action :flush_logger
  def flush_logger
    @@logger.flush_logs
  end
end