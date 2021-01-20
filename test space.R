library(Lahman)
library(dslabs)
library(broom)
library(tidyverse)
library(tidyr)
library(dplyr)
library(purrr)
library(caret)
#test space

# set.seed(1) # if using R 3.5 or earlier
# set.seed(1, sample.kind = "Rounding") # if using R 3.6 or later
# disease <- sample(c(0,1), size=1e6, replace=TRUE, prob=c(0.98,0.02))
# test <- rep(NA, 1e6)
# test[disease==0] <- sample(c(0,1), size=sum(disease==0), replace=TRUE, prob=c(0.90,0.10))
# test[disease==1] <- sample(c(0,1), size=sum(disease==1), replace=TRUE, prob=c(0.15, 0.85))
# 
# mean(test)
# 
# library(dslabs)
# data("heights")
# heights %>% 
#   mutate(height = round(height)) %>%
#   group_by(height) %>%
#   summarize(p = mean(sex == "Male")) %>%
#   qplot(height, p, data =.)

# ps <- seq(0, 1, 0.1)
# heights %>% 
#   mutate(g = cut(height, quantile(height, ps), include.lowest = TRUE)) %>%
#   group_by(g) %>%
#   summarize(p = mean(sex == "Male"), height = mean(height)) %>%
#   qplot(height, p, data =.)

# Sigma <- 9*matrix(c(1,0.5,0.5,1), 2, 2)
# dat <- MASS::mvrnorm(n = 10000, c(69, 69), Sigma) %>%
#   data.frame() %>% setNames(c("x", "y"))
# 
# ps <- seq(0, 1, 0.1)
# dat %>% 
#   mutate(g = cut(x, quantile(x, ps), include.lowest = TRUE)) %>%
#   group_by(g) %>%
#   summarize(y = mean(y), x = mean(x)) %>%
#   qplot(x, y, data =.)


# n1 <- c(100, 500, 1000, 5000, 10000)
# Sigma <- 9*matrix(c(1.0, 0.5, 0.5, 1.0), 2, 2)
# new_dat <- MASS::mvrnorm(1000, c(69, 69), Sigma) %>%
#    data.frame() %>% setNames(c("x", "y"))

# 
# results_fun = function(n){ 
#    Sigma <- 9*matrix(c(1.0, 0.5, 0.5, 1.0), 2, 2)
#    new_dat <- MASS::mvrnorm(100, c(69, 69), Sigma) %>%
#       data.frame() %>% setNames(c("x", "y"))
#    rep = replicate(n, {
#    trainIndex <- createDataPartition(dat$y, p = .5, list = FALSE, times = 1) 
#    train_dat = new_dat[-trainIndex, ]
#    test_dat = new_dat[trainIndex, ]
#    fit = lm(y~x, data = train_dat)
#    y_hat <- predict(fit, newdata = test_dat)
#    rmse = RMSE(y_hat, test_dat$y)
#    })
#    avg = mean(rep)
#    sd1 = sd(rep)
#    return(c(avg,sd1))
# }
# 
# set.seed(1, sample.kind="Rounding")
# created_fun = sapply(c(100, 500, 1000, 5000, 10000), results_fun)
# created_fun





# ## this is a copy of the code that works for a data set of n = 100
# set.seed(1, sample.kind="Rounding") # if using R 3.6 or later
# n <- 100
# Sigma <- 9*matrix(c(1.0, 0.5, 0.5, 1.0), 2, 2)
# dat <- MASS::mvrnorm(n = 100, c(69, 69), Sigma) %>%
#   data.frame() %>% setNames(c("x", "y"))
# 
# set.seed(1, sample.kind="Rounding")
#  results <- replicate(100, {
#    trainIndex <- createDataPartition(dat$y, p = .5, list = FALSE, times = 1) 
#    train_dat = dat[-trainIndex, ]
#    test_dat = dat[trainIndex, ]
#    fit = lm(train_dat$y~train_dat$x)
#    y_hat <- fit$coefficients[1] + fit$coefficients[2]*test_dat$x
#    RMSE(y_hat, test_dat$y)
#    
#    
#                                                     
#  })
#   
# 
# mean(results)
# sd(results)
# 


## this is a copy of the code that works for a data set of n = 100
# set.seed(1, sample.kind="Rounding") # if using R 3.6 or later
# n <- 100
# Sigma <- 9*matrix(c(1.0, 0.95, 0.95, 1.0), 2, 2)
# dat <- MASS::mvrnorm(n = 100, c(69, 69), Sigma) %>%
#    data.frame() %>% setNames(c("x", "y"))
# 
# set.seed(1, sample.kind="Rounding")
#  results <- replicate(100, {
#    trainIndex <- createDataPartition(dat$y, p = .5, list = FALSE, times = 1)
#    train_dat = dat[-trainIndex, ]
#    test_dat = dat[trainIndex, ]
#    fit = lm(train_dat$y~train_dat$x)
#    y_hat <- fit$coefficients[1] + fit$coefficients[2]*test_dat$x
#    RMSE(y_hat, test_dat$y)
# 
# 
# 
#  })
# 
# 
# mean(results)
# sd(results)
# 

# set.seed(1) # if using R 3.5 or earlier
set.seed(1, sample.kind="Rounding") # if using R 3.6 or later
Sigma <- matrix(c(1.0, 0.75, 0.75, 0.75, 1.0, 0.25, 0.75, 0.25, 1.0), 3, 3)
dat <- MASS::mvrnorm(n = 100, c(0, 0, 0), Sigma) %>%
   data.frame() %>% setNames(c("y", "x_1", "x_2"))

test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
train_set <- dat %>% slice(-test_index)
test_set <- dat %>% slice(test_index)

fit = lm(y~x_1, dat = train_set)
fit = lm(y~x_2 + x_1, data = train_set)
y_hat <- predict(fit, newdata = test_set)
rmse = sqrt(mean((y_hat-test_set$y)^2))
rmse
fit <- lm(y ~ x_1 + x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))




set.seed(1, sample.kind="Rounding") # if using R 3.6 or later
Sigma <- matrix(c(1.0, 0.75, 0.75, 0.75, 1.0, 0.95, 0.75, 0.95, 1.0), 3, 3)
dat <- MASS::mvrnorm(n = 100, c(0, 0, 0), Sigma) %>%
   data.frame() %>% setNames(c("y", "x_1", "x_2"))

fit <- lm(y ~ x_1, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_1 + x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

# set.seed(1) # if using R 3.5 or earlier
set.seed(1, sample.kind="Rounding") # if using R 3.6 or later
test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
train_set <- dat %>% slice(-test_index)
test_set <- dat %>% slice(test_index)

fit <- lm(y ~ x_1, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_1 + x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))
