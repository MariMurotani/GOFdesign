require "#{Rails.root}/lib/logger/command.rb"
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
require "#{Rails.root}/lib/logger/decorator.rb"
Dir[File.dirname(__FILE__) + '/decorators/*.rb'].each {|file| require file }
require 'singleton'

class AnyLogger
  include Singleton
  # require "#{Rails.root}/lib/logger/any_logger.rb"
  # logger = AnyLogger.new(Account.last)
  # logger.add_operation(BugReportCommand, JsonDecorator)
  # logger.add_operation(DBCommand, QueryDecorator)
  # logger.add_operation(TextLogCommand, TextDecorator)
  # logger.add_logs('test1', 'test1test1test1', Operation.last)
  # logger.add_logs('test2', 'test2test2test2', Operation.last)
  # logger.add_logs('test3', 'test3test3test3', Operation.last)
  # logger.flush_logs
  def initialize(account=nil)
    @account = account
    @commands = Array.new
    @logs = Array.new
  end

  def add_operation(command, decorator)
    @commands << {cmd: command, formatter: decorator}
  end

  def add_logs(title, description, operation)
    @logs << {title: title, description: description, operation: operation}
  end

  def flush_logs
    @commands.each do | commands |
      decorator = commands[:formatter].new(SimpleFormatter.new(commands[:cmd].new, @account))
      @logs.each.each do | log |
        decorator.format_line(log)
      end
      decorator.execute
    end
  end
end