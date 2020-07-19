class SimpleFormatter
  attr_reader :account
  def initialize(command, account)
    @command = command
    @account = account
    @result = []
  end
  def format_line(row)
    @result << row
  end
  def execute
    @command.execute(@result)
  end
end