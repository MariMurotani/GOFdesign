class ReportMail::HTMLReport < ReportMail::Report
  def output_start
    <<~"EOS"
      <h1>注文情報</h1>
    EOS
  end

  def output_head
    result = "<ul>"
    result += "<li>アカウント名: #{@order_builder.dig(:account)&.dig(:name)}</li>"
    result += "<li>メールアドレス: #{@order_builder.dig(:account)&.dig(:email)}</li>"
    result += "<li>配送方法; #{@order_builder.dig(:order)&.dig(:delivery_method)}</li>"
    result += "<li>配送先: #{@order_builder.dig(:address)&.dig(:postal_code)}</li>"
    result += "<li>  #{@order_builder.dig(:address)&.dig(:address)}</li>"
    result += "</ul>"
  end

  def output_body_start
    <<~"EOS"
      <h1>商品情報</h1>
    EOS
  end

  def output_body
    result = "<ul>"
    @order_builder[:order][:products].each_with_index do |order, index|
      result += "<li>#{index}: #{order&.dig(:name)} / #{order&.dig(:quantity)}個</li>"
      result += "<li>    (#{order&.dig(:expected_delivery_date)}到着予定})</li>"
      result += "<hr>" if index != (@order_builder[:order][:products].count - 1)
    end
    result += "</ul>"
    result
  end

  def output_body_end
    <<~"EOS"
      <hr>
      ■ 〇〇屋さん<br>
      〒 000-0000<br>
      東京都〇〇区〇〇 123-1<br>
      mail: general@com<br>
      tel: 03-1234-0000<br>
      <hr>
    EOS
  end

  def output_end
    ""
  end
end
