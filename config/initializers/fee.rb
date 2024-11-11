FEE = {
  cod_fee: [
    { range: 0...10_000, fee: 300 },
    { range: 10_000...30_000, fee: 400 },
    { range: 30_000...100_000, fee: 600 },
    { range: 100_000..Float::INFINITY, fee: 1000 }
  ],             # 　代引き手数料
  shipping_fee_interval: 5, # 　送料が加算される商品数の間隔
  shipping_fee: 600,        # 　shipping_fee_intervalごとに加算される送料
  tax_rate: 0.08            # 　消費税率
}
