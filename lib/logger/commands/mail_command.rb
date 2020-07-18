class BugReportCommand < Command
  def execute(rows)

    #　アカウントから宛先メールアドレスを取得？
    body = rows.join('<BR>')

  end
end