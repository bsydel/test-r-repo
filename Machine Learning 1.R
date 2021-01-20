library(tidyverse)
library(caret)
library(dslabs)
data(heights)


# y <- heights$sex
# x <- heights$height
# 
# set.seed(2, sample.kind = "Rounding") # if using R 3.5 or earlier, remove the sample.kind argument
# test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)
# test_set <- heights[test_index, ]
# train_set <- heights[-test_index, ]

library(dslabs)
library(dplyr)
library(lubridate)
data(reported_heights)

dat <- mutate(reported_heights, date_time = ymd_hms(time_stamp)) %>%
  filter(date_time >= make_date(2016, 01, 25) & date_time < make_date(2016, 02, 1)) %>%
  mutate(type = ifelse(day(date_time) == 25 & hour(date_time) == 8 & between(minute(date_time), 15, 30), "inclass","online")) %>%
  select(sex, type)

y <- factor(dat$sex, c("Female", "Male"))
x <- dat$type




mean(y_hat == dat$sex)
y_hat <- ifelse(x == "inclass", "Female", "Male") %>% factor(levels = levels(test_set$sex)) #make y_hat male or female depending on dat$type == to inclass
mean(y == y_hat) # see how often the prediction is == to actual value of dat$sex -- but turned into a factor first -- above in code line 25
