class Decorator
  def initialize(real_formatter)
    @real_formatter = real_formatter
    @result = []
    @pos = 1
  end
  def account
    @real_formatter.account
  end
  def format_line(row)
    @real_formatter.format_line(row)
  end
  def pos
    @real_formatter.pos
  end
  def execute
    @real_formatter.execute
  end
end