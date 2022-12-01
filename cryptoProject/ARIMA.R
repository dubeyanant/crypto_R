BTC <-  subset(Bitcoin, select = c(Date, Close))

rm(btctime)
btctime = ts(BTC$Close, start = min(BTC$Date), end = max(BTC$Date), frequency = 1)


