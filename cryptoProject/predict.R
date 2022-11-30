#install.packages("tidyverse")
#install.packages("ggplot")

library(tidyverse)
library(ggplot2)

qplot(Date, Close, data = Bitcoin, geom = "line")

model <- lm(Close ~ Date, data = Bitcoin)
rm(BitcoinPredict) + rm(new_row)
BitcoinPredict <- subset(Bitcoin, select = c(Date, Close))

# Reversing Data set
BitcoinPredict <- as.data.frame(apply(BitcoinPredict, 2, rev))


new_row <- data.frame(seq(as.Date("2022-11-22"), as.Date("2025-12-31"), by="days"),
                      predict(model, data.frame(Date = seq(as.Date("2022-11-22"), as.Date("2025-12-31"), by="days"))))
names(new_row) <- names(BitcoinPredict)
new_row$Date <- as.character(new_row$Date)

BitcoinPredict <- rbind(BitcoinPredict, new_row)

BitcoinPredict <- as.data.frame(apply(BitcoinPredict, 2, rev))

BitcoinPredict$Date <- as.Date(BitcoinPredict$Date)
BitcoinPredict$Close <- as.numeric(BitcoinPredict$Close)

rownames(BitcoinPredict) <- 1:nrow(BitcoinPredict) 

plot(BitcoinPredict$Date, BitcoinPredict$Close,
     type="l",main="Crypto",xlab="Date",ylab="Close")
qplot(Date, Close, data = BitcoinPredict, geom = "line") + geom_smooth(method = "lm", se = FALSE)
