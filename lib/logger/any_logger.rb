require 'singleton'
require "#{Rails.root}/lib/logger/command.rb"
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
require "#{Rails.root}/lib/logger/decorator.rb"
Dir[File.dirname(__FILE__) + '/decorators/*.rb'].each {|file| require file }

# require "#{Rails.root}/lib/logger/any_logger.rb"
# logger = AnyLogger.new
# logger.add_operation(BugReportCommand, JsonDecorator)
# logger.add_operation(DBCommand, QueryDecorator)
# logger.add_operation(TextLogCommand, TextDecorator)
# logger.add_logs('test1', 'test1test1test1', Account.system, Operation.last)
# logger.add_logs('test2', 'test2test2test2', Account.system, Operation.last)
# logger.add_logs('test3', 'test3test3test3', Account.system, Operation.last)
# logger.flush_logs
class AnyLogger
  include Singleton
  def initialize
    @commands = Array.new
    @logs = Array.new
  end
  def has_operation?(specific_command)
    selected = @commands.filter do |command|
      command[:cmd] == specific_command
    end
    selected.length > 0
  end
  def add_operation(command, decorator)
    @commands << {cmd: command, formatter: decorator}
  end
  def add_logs(title, description, account, operation)
    @logs << {title: title, description: description, account: account, operation: operation}
  end
  def flush_logs
    @local_logs = @logs.dup
    @logs = Array.new
    @commands.each do | commands |
      decorator = commands[:formatter].new(SimpleFormatter.new(commands[:cmd].new))
      @local_logs.each.each do | log |
        decorator.format_line(log)
      end
      decorator.execute
    end
  end
end