BTC <-  subset(Bitcoin, select = c(Date, Close)) # Loading dataset

# ---- Starting aggregating
library(dplyr)
BTC <- arrange(BTC, Date) # Arranging Date in ascending order

library(zoo)
BTC$qdate <- as.yearqtr(BTC$Date) # Deriving quarterly dates

BTC_q <- BTC %>%
  group_by(qdate) %>%
  summarise_all(mean) # Grouping quarterly dates
# ---- Stopped aggregating

BTC_qtrly <-  subset(BTC_q, select = c(qdate, Close)) # Creating new data set

# ---- Starting Time Series

# Creating a time series
btctime <- ts(BTC_qtrly$Close, start = min(BTC_qtrly$qdate), end = max(BTC_qtrly$qdate), frequency = 4)

library(forecast)
library(tseries)

#plot(btctime)

# Checking if the data is static
acf(btctime)
pacf(btctime)
adf.test(btctime)

btcmodel <- auto.arima(btctime, ic = "aic", trace = TRUE) # Making the data set more static

btcmodel

# Checking if the data is static
acf(ts(btcmodel$residuals))
pacf(ts(btcmodel$residuals))

rm(BTC) + rm(BTC_q) + rm(BTC_qtrly) + rm(btctime) # Removing variables from memory

#mybtcforecast <- forecast(btcmodel, level = c(95), h = 1)
#mybtcforecast
#plot(mybtcforecast)

# ---- Stopped Time Series
