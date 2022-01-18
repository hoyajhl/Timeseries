##Hands on Time series analysis with R 
# Chapter 3 Code
install.packages("forecast")
install.packages("Quandl")
install.packages("TSstudio")
library(forecast)
library(stats)
library(Quandl)

# -------- Code Chank 1 --------
NGC <-Quandl(code = "FRED/NATURALGAS",
             collapse="quarterly",
             type = "ts",
             end_date = "2017-12-31")
class(NGC) ## ts
# -------- Code Chank 2 --------
plot.ts(NGC,
        main = "US Quarterly Natural Gas Consumption",
        ylab = "Billion of Cubic Feet")
# -------- Code Chank 3 --------
is.ts(NGC) # Test if the object is a "ts" class
length(NGC) # Get the number of observations, 72

# -------- Code Chank 4 --------
head(NGC, 32) 

# -------- Code Chank 5 --------
head(cycle(NGC), 4)
head(time(NGC), 4) ## 2000.00 2000.25 2000.50 2000.75

# -------- Code Chank 6 --------
frequency(NGC)## 4
deltat(NGC)## 0.25

# -------- Code Chank 7 --------

library(TSstudio)
data(Coffee_Prices)
class(Coffee_Prices) ## "mts"    "ts"     "matrix"
head(Coffee_Prices)

# -------- Code Chank 8 --------
str(Coffee_Prices)
frequency(Coffee_Prices) ##12
deltat(Coffee_Prices) ## 0.08333333
head(time(Coffee_Prices)) ## 1960.000 1960.083 1960.167 1960.250 1960.333 1960.417
head(cycle(Coffee_Prices),13) ## 1  2  3  4  5  6  7  8  9 10 11 12  1
tail(time(Coffee_Prices)) ## 2017.917 2018.000 2018.083 2018.167 2018.250 2018.333
# -------- Code Chank 9 --------
my_ts <- ts(data = 1:60, # The series values
            start = c(2010, 1), # The time of the first observation
            end = c(2014, 12),  # The time of the last observation
            frequency = 12) # The Series frequency

class(my_ts)
my_ts
# -------- Code Chank 10 --------
# Define the start time with two integers vector
series_1 <- ts(data = 1:60,
               start = c(2010, 1),
               frequency = 12)
# Define the start time with a single integer
series_2 <- ts(data = 1:60,
               start = 2010,
               frequency = 12)
# Define the end time with two integers vector
series_3 <- ts(data = 1:60,
               end = c(2014, 12),
               frequency = 12)

# comparing all the three series to the my_ts series we defined above
identical(my_ts, series_1, series_2, series_3)

# -------- Code Chank 11 --------
library(TSstudio)
data(US_indicators)
str(US_indicators)
# -------- Code Chank 12 --------
tvs <- US_indicators[, c("Date", "Vehicle Sales")] 
str(tvs)

# -------- Code Chank 13 --------
library(dplyr)
tvs <- tvs %>% arrange(Date)
head(tvs)

# -------- Code Chank 14 --------
library(lubridate)
tvs$year <- year(tvs$Date) ## year function
tvs$month <- month(tvs$Date) ## moth function
head(tvs)

# -------- Code Chank 15 --------
first_cycle_number <- tvs$year[which.min(tvs$Date)]
first_cycle_unit <- tvs$month[which.min(tvs$Date)]
print(c(first_cycle_number, first_cycle_unit))

# -------- Code Chank 16 --------
tvs_ts <- ts(data = tvs$`Vehicle Sales`,
             start = c(first_cycle_number, first_cycle_unit),
             frequency = 12) ## using ts
 
# -------- Code Chank 17 --------
head(tvs$Date, 5)
head(time(tvs_ts), 5) ## 1976.000 1976.083 1976.167 1976.250 1976.333

# -------- Code Chank 18 --------
head(tvs$`Vehicle Sales`)
head(tvs_ts)
identical(tvs$`Vehicle Sales`, as.numeric(tvs_ts))

# -------- Code Chank 19 --------
US_indicators <- US_indicators %>% arrange(Date)

US_indicators_ts <- ts(data = US_indicators[, c("Vehicle Sales", "Unemployment Rate")],
                       start = c(year(min(tvs$Date)), month(min(tvs$Date))), 
                       frequency = 12)
class(US_indicators_ts) ## [1] "mts"    "ts"     "matrix"
head(US_indicators_ts)
# -------- Code Chank 20 --------
start(NGC)
end(NGC)
frequency(NGC)
# -------- Code Chank 21 --------
window(NGC, start = c(2005,1), end = c(2005, 4)) ## quarter1-4 return value

# -------- Code Chank 22 --------
window(NGC, start = c(2000, 3), frequency = 1)

# -------- Code Chank 23 --------
window(NGC, start = c(2006, 3), end = c(2012, 3),frequency = 1)

# -------- Code Chank 24 --------
NGC_year <- aggregate(NGC, nfrequency = 1, FUN = "sum") ##  sum of the each year  
NGC_year

# -------- Code Chank 26 --------
NGC_lag4 <- stats::lag(NGC, k = -4)
## lag 4, k=-4 
## Past lags, or simply lags, represent a shift in the series by n steps back, with respect to the original series.

ts_info(NGC_lag4)
# -------- Code Chank 27 --------
# plot.ts function from the stats package 

plot.ts(tvs_ts, 
        main = "US Monthly Total Vehicle Sales",
        ylab = "Thousands of Vehicle",
        xlab = "Time")

# -------- Code Chank 28 --------
plot.ts(US_indicators_ts,
        plot.type = "multiple",
        main = "US Monthly Vehicle Sales vs. Unemployment Rate",
        xlab = "Time") ## 2 datas involved
# -------- Code Chank 29 --------
install.packages("dygraphs")
library(dygraphs)  

# visualizing time series objects using dygraphs
dygraph(tvs_ts, 
        main = "US Monthly Total Vehicle Sales",
        ylab = "Thousands of Vehicle") %>% 
  dyRangeSelector()

# -------- Code Chank 30 --------
dygraph(US_indicators_ts,
        main = "US Monthly Vehicle Sales vs. Unemployment Rate") %>%
  dyAxis("y", label = "Vehicle Sales") %>%
  dyAxis("y2", label = "Unemployment Rate") %>%
  dySeries("Vehicle Sales", axis = 'y', color = "green") %>%
  dySeries("Unemployment Rate", axis = 'y2', color = "red") %>%
  dyLegend(width = 400) 

# -------- Code Chank 31 --------

#TSstudio package provides us with a set of interactive applications for descriptive and predictive analysis of time series. This includes the ts_plot function for visualizing time series objects using the plotly package visualization engine#

library(TSstudio)

ts_plot(tvs_ts,
        title = "US Monthly Total Vehicle Sales",
        Ytitle = "Thousands of Vehicle",
        slider = TRUE)

# -------- Code Chank 32 --------
ts_plot(US_indicators_ts, 
        title = "US Monthly Vehicle Sales vs. Unemployment Rate",
        type = "multiple")