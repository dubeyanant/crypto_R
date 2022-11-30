#bitcoin_data <- read.csv("/Users/pareshmahajan/Paresh/Sem1 MIT/Data Mining/crypto_R/Bitcoin_Data.csv") # Importing .csv file
bitcoin_data <- read.csv(paste(as.character(getwd()),"/Bitcoin_Data.csv", sep=""))
bitcoin_data # Printing the data frame

nrow(bitcoin_data) # Printing total number of rows in the data set

#Cleaning the data set by removing the $ and , with the gsub and than doing the same operation on every column using lapply
Bitcoin <- data.frame(lapply(bitcoin_data, gsub, pattern='[\\$,]', replacement=''))

#Removing left white space by using str_trim() function and looping the same function for every column using lapply
#install.packages("stringr") # Install the stringr package to use str_trim
library(stringr)
Bitcoin <- data.frame(lapply(df, function(x)str_trim(x)))
Bitcoin

Bitcoin[3495,] # printing last row of the data frame

Bitcoin$Open <- as.numeric(df$Open) # Changing string type to numeric
Bitcoin$High <- as.numeric(df$High) # Changing string type to numeric
Bitcoin$Low <- as.numeric(df$Low) # Changing string type to numeric
Bitcoin$Close <- as.numeric(df$Close) # Changing string type to numeric
Bitcoin$Volume <- as.numeric(df$Volume) # Changing string type to numeric
Bitcoin$Market.Cap <- as.numeric(df$Market.Cap) # Changing string type to numeric
Bitcoin$Date <- as.Date(df$Date, format = "%B %d %Y") # Changing date formats

