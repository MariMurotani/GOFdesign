class JsonDecorator < Decorator
  def format_line(row)
    @real_formatter.format_line(
        {
            no: @pos,
            title: row['title'],
            description: row['description'],
            account: self.account.id,
            operation: row['operation'].name
        }.to_json)
  end
end