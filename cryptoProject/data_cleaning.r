#Bitcoin Cleaning
bitcoin_data <- read.csv(paste(as.character(getwd()),"/Bitcoin.csv", sep="")) # Reading csv file

bitcoin_data # Printing data frame

#Cleaning the data set by removing the $ and ,
Bitcoin <- data.frame(lapply(bitcoin_data, gsub, pattern='[\\$,]', replacement=''))

#install.packages("stringr")
library(stringr)

#Removing left white space by using str_trim()
Bitcoin <- data.frame(lapply(Bitcoin, function(x)str_trim(x)))

Bitcoin$Date <- as.Date(Bitcoin$Date, format = "%B %d %Y") # Changing date formats

Bitcoin[,-1] <- data.frame(lapply(Bitcoin[,-1], as.numeric)) # Changing string to numeric


#Ethereum Cleaning
Ethereum <- read.csv(paste(as.character(getwd()),"/Ethereum.csv", sep=""))
Ethereum <- data.frame(lapply(Ethereum, gsub, pattern='[\\$,]', replacement=''))
Ethereum <- data.frame(lapply(Ethereum, function(x)str_trim(x)))
Ethereum$Date <- as.Date(Ethereum$Date, format = "%B %d %Y")
Ethereum[,-1] <- data.frame(lapply(Ethereum[,-1], as.numeric))

#DogeCoin Cleaning
