class ReportMail::TextReport < ReportMail::Report
  def output_start
<<"EOS"
-------------------------------
■ 注文情報
-------------------------------
EOS
  end
  def output_head
    result = "アカウント名: #{@order_builder.dig(:account)&.dig(:name)}" + "\n"
    result += "メールアドレス: #{@order_builder.dig(:account)&.dig(:email)}" + "\n"
    result += "配送方法; #{@order_builder.dig(:order)&.dig(:delivery_method)}" + "\n"
    result += "配送先: #{@order_builder.dig(:address)&.dig(:postal_code)}" + "\n"
    result += "#{@order_builder.dig(:address)&.dig(:address)}" + "\n"
  end
  def output_body_start
<<"EOS"
-------------------------------
■ 商品情報
-------------------------------
EOS
  end
  def output_body
    result = ""
    @order_builder[:order][:products].each_with_index do | order, index |
      result += "#{index}: #{order&.dig(:name)} / #{order&.dig(:quantity)}個" + "\n"
      result += "    (#{order&.dig(:expected_delivery_date)}到着予定})" + "\n"
      result += "------" if index != (@order_builder[:order][:products].count-1)
    end
    result
  end
  def output_body_end
<<"EOS"
-------------------------------
■ 〇〇屋さん
〒 000-0000
東京都〇〇区〇〇 123-1
mail: general@com
tel: 03-1234-0000
-------------------------------
EOS
  end
  def output_end
    ""
  end
end