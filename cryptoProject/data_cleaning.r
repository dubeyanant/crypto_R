#bitcoin_data <- read.csv("/Users/pareshmahajan/Paresh/Sem1 MIT/Data Mining/crypto_R/Bitcoin_Data.csv") # Importing .csv file
bitcoin_data <- read.csv(paste(as.character(getwd()),"/Bitcoin_Data.csv", sep=""))
bitcoin_data # Printing the data frame

nrow(bitcoin_data) # Printing total number of rows in the data set

#Cleaning the data set by removing the $ and , with the gsub and than doing the same operation on every column using lapply
Bitcoin <- data.frame(lapply(bitcoin_data, gsub, pattern='[\\$,]', replacement=''))

#Removing left white space by using str_trim() function and looping the same function for every column using lapply
#install.packages("stringr") # Install the stringr package to use str_trim
library(stringr)
Bitcoin <- data.frame(lapply(Bitcoin, function(x)str_trim(x)))
Bitcoin

Bitcoin[3495,] # printing last row of the data frame

Bitcoin$Open <- as.numeric(Bitcoin$Open) # Changing string type to numeric
Bitcoin$High <- as.numeric(Bitcoin$High) # Changing string type to numeric
Bitcoin$Low <- as.numeric(Bitcoin$Low) # Changing string type to numeric
Bitcoin$Close <- as.numeric(Bitcoin$Close) # Changing string type to numeric
Bitcoin$Volume <- as.numeric(Bitcoin$Volume) # Changing string type to numeric
Bitcoin$Market.Cap <- as.numeric(Bitcoin$Market.Cap) # Changing string type to numeric
Bitcoin$Date <- as.Date(Bitcoin$Date, format = "%B %d %Y") # Changing date formats

