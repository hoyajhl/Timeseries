##Hands on Time series analysis with R 
# Chapter 2 Code

# The Sys.Date function get the current date from the system 
date <- Sys.Date() 
date
class(date) ## "Date"

# The Sys.time function get the current date and time from the system 
# The defualt format is POSIXct
time_ct <- Sys.time() 
time_ct
class(time_ct) ## "POSIXct" "POSIXt" 

# Converting the POSIXct object to POSIXlt 
time_lt <- as.POSIXlt(time_ct)
time_lt
class(time_lt)

# -------- Code Chank 2 --------
# Unclass the POSIXct object
unclass(time_ct)
# Unclass the POSIXlt object
unclass(time_lt)

# -------- Code Chank 3 --------
# Quering for the second value 
unclass(time_lt)$sec #  59.20666
# Quering for the day of the year value
unclass(time_lt)$yday # 17

# -------- Code Chank 4 --------
date <- as.Date("2022-01-17")
date
class(date) 

# Creating POSIXct and POSIXlt objects
# Setting the time zone to EST
time_ct <- as.POSIXct("2014-5-12 20:05:35", tz = "EST")
time_ct ##" 2014-05-12 20:05:35 EST"
class(time_ct) # "POSIXct" "POSIXt" 

time_lt <- as.POSIXlt("2014-5-12 20:05:35", tz = "EST")
time_lt ## "2014-05-12 20:05:35 EST" 
class(time_lt) # "POSIXlt" "POSIXt" 

# -------- Code Chank 5 --------
url <- "https://raw.githubusercontent.com/PacktPublishing/Hands-On-Time-Series-Analysis-with-R/master/Chapter02/dates_formats.csv"
dates_df <- read.csv(url, stringsAsFactors = FALSE)
# -------- Code Chank 6 --------
str(dates_df) ## variables->chr 

# -------- Code Chank 7 --------
dates_df$Japanese_format_new <- as.Date(dates_df$Japanese_format)
str(dates_df$Japanese_format_new) ## Date format
# -------- Code Chank 8 --------
head(dates_df[, c("Japanese_format", "Japanese_format_new")])

# -------- Code Chank 9 --------
identical(dates_df$Japanese_format, dates_df$Japanese_format_new)
class(dates_df$Japanese_format)
class(dates_df$Japanese_format_new)

# -------- Code Chank 10 --------
as.Date("31-01-2018") 

# -------- Code Chank 11 --------
as.Date("31-01-2018", format = "%d-%m-%Y")

# -------- Code Chank 12 --------
# Excel US date format
dates_df$US_format[1]  ## "1/20/2017"
dates_df$US_format_new <- as.Date(dates_df$US_format, 
                                  format = "%m/%d/%Y") 
str(dates_df$US_format_new )
# Excel US date long format 
dates_df$US_long_format[1] ##"Friday, January 20, 2017"
dates_df$US_long_format_new <- as.Date(dates_df$US_long_format, 
                                       format = "%A, %B %d, %Y")
dates_df$US_long_format_new[1] ## "2017-01-20"
# Excel Canada format
dates_df$CA_mix_format[1] 
dates_df$CA_mix_format_new <- as.Date(dates_df$CA_mix_format, 
                                      format = "%B %d, %Y")
dates_df$CA_mix_format_new[1] ## "2017-01-20"
# Excel South Africa format
dates_df$SA_mix_format[1]  ## "20 January 2017"
dates_df$SA_mix_format_new <- as.Date(dates_df$SA_mix_format, 
                                      format = "%d %B %Y") 

# Excel South Africa format
dates_df$NZ_format[1] ##"20/01/2017"
dates_df$NZ_format_new <- as.Date(dates_df$NZ_format, 
                                  format = "%d/%m/%Y") 

# -------- Code Chank 13 --------
date1 <- as.Date("1970-01-01")
date2 <- Sys.Date()

print(c(date1, date2)) ## "1970-01-01" "2022-01-18"

# -------- Code Chank 14 --------
date2 - date1  ## Time difference of 19010 days

# -------- Code Chank 15 --------
as.numeric(date1) ## 0
as.numeric(date2) ## 19010

# -------- Code Chank 16 --------
head(dates_df$Excel_Numeric_Format)

# -------- Code Chank 17 --------
dates_df$Excel_Numeric_Format_new <- as.Date(dates_df$Excel_Numeric_Format, 
                                             origin = as.Date("1899-12-30"))
head(dates_df$Excel_Numeric_Format_new)

# -------- Code Chank 18 --------
str(dates_df)

# -------- Code Chank 19 --------
# Storing a time object as a string
time_str <- "2018-12-31 23:59:59"
class(time_str)

# Converting the time object to POSIXct object
time_posix_ct1 <- as.POSIXct(time_str)
class(time_posix_ct1)

# Lets see how the two objects looks like
time_str
time_posix_ct1

# Test if the two objects are identical 
identical(time_str, time_posix_ct1)

# -------- Code Chank 20 --------
# Storing a numeric representation of the time object
time_numeric <- 1546318799
class(time_numeric)
# Converting the numeric time object to a POSIXct object
time_posix_ct2  <- as.POSIXct(time_numeric, origin = "1970-01-01")
time_posix_ct2 ### "2018-12-31 23:59:59 EST"

# -------- Code Chank 21 --------
# Store the time object as a string input
time_US_str <- "Monday, December 31, 2018 11:59:59 PM"

# Convert the time input to POSIXct format
time_posix_ct3 <- as.POSIXct(time_US_str,
                             format = "%A, %B %d, %Y %I:%M:%S %p")

time_posix_ct3 ## "2018-12-31 23:59:59 EST"


# -------- Code Chank 23 --------
# Let's use again the same time object as earlier
time_str <- "2018-12-31 23:59:59"
# Converting the object without declaring about the time zone
time_default_tz <- as.POSIXct(time_str)
# Converting the object but declaring about the time zone
time_assign_tz <- as.POSIXct(time_str, tz = "GMT")

print(c(time_default_tz, time_assign_tz))## "2018-12-31 23:59:59 EST" "2018-12-31 18:59:59 EST"


# -------- Code Chank 25 --------
# Creating daily index with date object
daily_index <- seq.Date(from = as.Date("2016-01-01"), # Setting the starting date
                        to = as.Date("2018-12-31"),  # Setting the end date
                        by = "day" # Setting the time increment
)

head(daily_index) 
# "2016-01-01" "2016-01-02" "2016-01-03" "2016-01-04" "2016-01-05" "2016-01-06"

# -------- Code Chank 26 --------
# Creating an index with 3 days interval space
daily_3_index <- seq.Date(from = as.Date("2016-01-01"), # Setting the starting date
                          to = as.Date("2018-12-31"),  # Setting the end date
                          by = "3 days" # Setting the time increment
)

head(daily_3_index)
# "2016-01-01" "2016-01-04" "2016-01-07" "2016-01-10" "2016-01-13" "2016-01-16"

# -------- Code Chank 27 --------
hourly_index <- seq.POSIXt(from = as.POSIXct("2018-06-01"), by = "hours", length.out = 48)

str(hourly_index)

# -------- Code Chank 28 --------
# Store the time object as a string input
time_US_str <- "Monday, December 31, 2018 11:59:59 PM"
class(time_US_str)
time_US_str

# -------- Code Chank 29 --------
# Time object conversion with the "base" package
time_base <- as.POSIXct(time_US_str,
                        format = "%A, %B %d, %Y %I:%M:%S %p")
class(time_base)
time_base

# -------- Code Chank 30 --------
# Time object conversion with the "lubridate" package
library(lubridate) 

time_lubridate <- mdy_hms(time_US_str, tz = "EST")
class(time_lubridate)## "POSIXct" "POSIXt" 
time_lubridate
