class BugReportCommand < Command
  def execute(rows)
    # 一件づつ送信を想定
    rows.each do | log |
      HTTP.post('log')
    end
  end
end