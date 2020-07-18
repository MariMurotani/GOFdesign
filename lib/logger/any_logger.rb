require "#{Rails.root}/lib/logger/command.rb"
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
require "#{Rails.root}/lib/logger/decorator.rb"
Dir[File.dirname(__FILE__) + '/decorators/*.rb'].each {|file| require file }

class AnyLogger
  # require "#{Rails.root}/lib/logger/any_logger.rb"
  # logger = AnyLogger.new(Account.last)
  def initialize(account=nil)
    @account = account
    @commands = []
    @logs = []

    # Debugコード
    @account = Account.last
    @logs << {title: "test1", description: "test1test1test1" ,"operation": Operation.last}
    @logs << {title: "test2", description: "test1test1test2" ,"operation": Operation.last}
    @commands << {cmd: BugReportCommand, formatter: JsonDecorator}
    @commands << {cmd: DBCommand, formatter: QueryDecorator}
    @commands << {cmd: MailCommand, formatter: HTMLDecorator}

  end

  def self.add_operation(command, decorator)
    @commands << @commands
    @decorators << decorator
  end

  def self.add_logs(title, description, operation)
    @logs << {title: title, description: description, operation: operation}
  end

  def self.flush_logs
    @commands.each do | commands |
      binding.pry
      decorator = commands[:formatter].new(SimpleFormatter.new(commands[:cmd], @account))
      @logs.each.each do | log |
        decorator.format_line(log)
      end
      decorator.execute
    end
  end
end