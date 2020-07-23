require "#{Rails.root}/lib/logger/any_logger.rb"
@@any_logger = AnyLogger.instance
@@any_logger.add_operation(BugReportCommand, JsonDecorator)
@@any_logger.add_operation(DBCommand, QueryDecorator)
@@any_logger.add_operation(TextLogCommand, TextDecorator)