class DBCommand < Command
  def execute(rows)
    # バルクインサート
    query = "INSERT INTO logs(description, account_id, operation_id, created_at, updated_at) values #{rows.join(',')}"
    ActiveRecord::Base.connection.execute(query)
  end
end