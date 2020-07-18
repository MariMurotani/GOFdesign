class DBCommand < Command
  def initialize(log)
    @log = log
  end
  def execute(rows)
    # バルクインサート
    query = "INSERT INTO logs(description, account_id, operation_id) values #{rows.join(',')}"
    @account.find_by_sql(query)
  end
end