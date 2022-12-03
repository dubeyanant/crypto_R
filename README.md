# Crypto-Currency History Tracking and Prediction

by [**Anant Dubey**](https://github.com/dubeyanant), [**Paresh Mahajan**](https://github.com/mahajanparesh) and **Udaykumar Thalishetti**.

---

### Problem Statement

There is a lack of common resources that display different cryptocurrency charts. There is a constant need for tracking, comparing two or more cryptocurrencies, and predicting cryptocurrencies. Common people don’t have the time and resources to find the data of the different cryptocurrencies, arrange it, and then use it to derive any sort of insight.

This problem was first identified when I was on the internet searching for data regarding the history of cryptocurrencies to track some coins, but I couldn’t find any. So, this project will help those who want to track the historical price of different cryptocurrencies and compare them to gain some sort of insight.

### Description of Data Set

We are using datasets of the three main cryptocurrencies in the crypto market, which are Bitcoin, Ethereum, and Dogecoin. These datasets were created by using a Python script to scrape cryptocurrency information from the coinmarketcap.com website and saving it in a .csv file. The dataset consists of 7 columns: date, open, high, low, close, volume, and market cap. 

### Objectives of the system

The system's goal is to create a system that displays a price vs. time graph of three cryptocurrencies, namely Bitcoin, Ethereum, and Dogecoin, compares two of them at the same time, and forecasts their prices for future quarters. 

### Module List

We have developed all these modules using the Shiny package in R.

Module 1: Displaying two graphs, which are **Price vs. Time** and **Market Capitalization vs. Time** charts depending on the user’s selected crypto currency.

Module 2: In this module, we are comparing the details of two crypto currencies depending on the user's input.

Module 3: Prediction of Cryptocurrency Using the **ARIMA Time-Series Forecasting Algorithm.**

### Limitations & Drawbacks

1. Our ARIMA prediction model can only forecast prices six quarters in advance.
2. Because we have limited hardware resources, this data is static rather than dynamic, as scraping data requires us to constantly run a server with a script.

### Future Enhancement

1. We would like to implement a bar plot (candlestick) chart for price vs. time for every crypto currency.
2. Implement the user-defined date range input for displaying the chart.
3. The data that we are showing on our local system, we would like to display all over the world using a web application.

### References and Bibliography

1. Cryptocurrency data scraped from: https://coinmarketcap.com/
2. UI Designing in R reference : https://shiny.rstudio.com/
3. Referred book: [R For Dummies Paperback – 21 July 2015 - Books](https://www.amazon.in/R-Dummies-Andrie-Vries/dp/1119055806) 
