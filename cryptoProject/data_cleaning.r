#install.packages("stringr")
library(stringr)

#Bitcoin Cleaning
Bitcoin <- read.csv(paste(as.character(getwd()),"/Bitcoin.csv", sep="")) # Reading csv file
Bitcoin <- data.frame(lapply(Bitcoin, gsub, pattern='[\\$,]', replacement='')) # Cleaning the data set by removing the $ and ,
Bitcoin <- data.frame(lapply(Bitcoin, function(x)str_trim(x))) # Removing left white space by using str_trim()
Bitcoin$Date <- as.Date(Bitcoin$Date, format = "%B %d %Y") # Changing date formats
Bitcoin[,-1] <- data.frame(lapply(Bitcoin[,-1], as.numeric)) # Changing string to numeric
Bitcoin$MarketCap <- Bitcoin$Market.Cap/1000000000

#Ethereum Cleaning
Ethereum <- read.csv(paste(as.character(getwd()),"/Ethereum.csv", sep=""))
Ethereum <- data.frame(lapply(Ethereum, gsub, pattern='[\\$,]', replacement=''))
Ethereum <- data.frame(lapply(Ethereum, function(x)str_trim(x)))
Ethereum$Date <- as.Date(Ethereum$Date, format = "%B %d %Y")
Ethereum[,-1] <- data.frame(lapply(Ethereum[,-1], as.numeric))
Ethereum$MarketCap <- Ethereum$Market.Cap/1000000000

#Dogecoin Cleaning
Doge_Coin <- read.csv(paste(as.character(getwd()),"/DogeCoin.csv", sep=""))
Doge_Coin <- data.frame(lapply(Doge_Coin, gsub, pattern='[\\$,]', replacement=''))
Doge_Coin <- data.frame(lapply(Doge_Coin, function(x)str_trim(x)))
Doge_Coin$Date <- as.Date(Doge_Coin$Date, format = "%B %d %Y")
Doge_Coin[,-1] <- data.frame(lapply(Doge_Coin[,-1], as.numeric))
Doge_Coin$MarketCap <- Doge_Coin$Market.Cap/1000000000
