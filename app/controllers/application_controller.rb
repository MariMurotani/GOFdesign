class ApplicationController < ActionController::Base
  require "#{Rails.root}/lib/logger/any_logger.rb"
  before_action :create_logger
  after_action :flush_logger
  def create_logger
    @@logger = AnyLogger.instance
    @@logger.add_operation(BugReportCommand, JsonDecorator) if !@@logger.has_operation?(BugReportCommand)
    @@logger.add_operation(DBCommand, QueryDecorator) if !@@logger.has_operation?(DBCommand)
    @@logger.add_operation(TextLogCommand, TextDecorator) if !@@logger.has_operation?(TextLogCommand)
  end
  def flush_logger
    @@logger.flush_logs
  end
end
