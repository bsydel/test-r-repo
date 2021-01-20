library(Lahman)
library(dslabs)
library(broom)
library(tidyverse)
library(tidyr)
library(dplyr)
library(purrr)
library(caret)

library(tidyverse)
library(lubridate)
library(purrr)
library(pdftools)

# fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
# dat <- map_df(str_split(pdf_text(fn), "\n"), function(s){
#   s <- str_trim(s)
#   header_index <- str_which(s, "2015")[1]
#   tmp <- str_split(s[header_index], "\\s+", simplify = TRUE)
#   month <- tmp[1]
#   header <- tmp[-1]
#   tail_index  <- str_which(s, "Total")
#   n <- str_count(s, "\\d+")
#   out <- c(1:header_index, which(n==1), which(n>=28), tail_index:length(s))
#   s[-out] %>%
#     str_remove_all("[^\\d\\s]") %>%
#     str_trim() %>%
#     str_split_fixed("\\s+", n = 6) %>%
#     .[,1:5] %>%
#     as_data_frame() %>% 
#     setNames(c("day", header)) %>%
#     mutate(month = month,
#            day = as.numeric(day)) %>%
#     gather(year, deaths, -c(day, month)) %>%
#     mutate(deaths = as.numeric(deaths))
# }) %>%
#   mutate(month = recode(month, "JAN" = 1, "FEB" = 2, "MAR" = 3, "APR" = 4, "MAY" = 5, "JUN" = 6, 
#                         "JUL" = 7, "AGO" = 8, "SEP" = 9, "OCT" = 10, "NOV" = 11, "DEC" = 12)) %>%
#   mutate(date = make_date(year, month, day)) %>%
#   dplyr::filter(date <= "2018-05-01")
# 
# span <- 60 / as.numeric(diff(range(dat$date)))
# fit <- dat %>% mutate(x = as.numeric(date)) %>% loess(deaths ~ x, data = ., span = span, degree = 1)
# dat %>% mutate(smooth = predict(fit, as.numeric(date))) %>%
#   ggplot() +
#   geom_point(aes(date, deaths)) +
#   geom_line(aes(date, smooth), lwd = 2, col = "red")
# span

library(broom)
# mnist_27$train %>% glm(y ~ x_2, family = "binomial", data = .) %>% tidy()
# qplot(x_2, y, data = mnist_27$train)
# 
# mnist_27$train %>% 
#   mutate(y = ifelse(y=="7", 1, 0)) %>%
#   ggplot(aes(x_2, y)) + 
#   geom_smooth(method = "loess")

mnist = read_mnist()
x = mnist$train$images
x2 = x

y = x[x>50 & x<250]
dim(y)
mean(x[x>50 | x<250])
nrow(x)

4159960 / (60000 * 784)

