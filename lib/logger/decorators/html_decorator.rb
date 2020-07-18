class JsonDecorator < Decorator
  def format_line(row)
    @real_formatter.format_line(
        "<div>
          <div>#{@pos}</div>
          <div>#{row['title']}</div>
          <div>#{row['description']}</div>
          <div>#{self.account.id}</div>
          <div>#{row['operation'].name}</div>
        </div>"
    )
  end
end