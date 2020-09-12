require 'singleton'
class AnyLogger
  include Singleton
  def initialize
    @commands = Array.new
    @logs = Array.new
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
      decorator = commands[:formatter].new(Decorators::SimpleFormatter.new(commands[:cmd].new))
      @local_logs.each do | log |
        decorator.format_line(log)
      end
      decorator.execute
    end
  rescue =>e
    raise StandardError
  end
end