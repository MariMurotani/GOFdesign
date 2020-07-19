class TextDecorator < Decorator
  def format_line(row)
    @real_formatter.format_line("#{Time.zone.now},#{@pos},#{row[:title]},#{row[:description]},#{self.account.id},#{row[:operation].name}")
  end
end