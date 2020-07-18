class QueryDecorator < Decorator
  def format_line(row)
    @real_formatter.format_line(
        "(''" + "#{row['title']}: #{row['description']}" + "', #{row['account'].id}, #{row['operation'].id})"
    )
  end
end