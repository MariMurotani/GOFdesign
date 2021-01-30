class Commands::BugReportCommand < Command
  def initialize
    @url = 'http://test.jp/'
  end

  def execute(rows)
    # 一件づつ送信を想定
    rows.each do |_log|
      uri = URI.parse(@url)
      # response = Net::HTTP.post_form(uri, rows.to_json)
    end
  end
end
