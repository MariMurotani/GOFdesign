class ApplicationController < ActionController::Base
  require "#{Rails.root}/lib/logger/any_logger.rb"
  before_action :create_logger
  after_action :flush_logger
  def create_logger
    @@logger = AnyLogger.new(Account.system)
    @@logger.add_operation(BugReportCommand, JsonDecorator)
    @@logger.add_operation(DBCommand, QueryDecorator)
    @@logger.add_operation(TextLogCommand, TextDecorator)
  end
  def flush_logger
    @@logger.flush_logs
  end
end
