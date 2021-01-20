library(Lahman)
library(dslabs)
library(broom)
library(tidyverse)
library(tidyr)
library(dplyr)
library(purrr)


#Teams1 = Teams %>% filter(yearID == 1971) # for 1971 only
Teams1 = Teams %>% filter(yearID %in% c(1961:2018))
# lm1 =  Teams1 %>% group_by(yearID) %>% do(model = tidy(lm(R~BB+HR, data = .)))
# lm2 = lm1$model
# lm3 =lm2[1]
# lm3


fit <- lm(R~BB+HR, data = Teams1)
tidy(fit)

# add confidence intervals with tidy
tidy(fit, conf.int = TRUE)

### get a ggplot and lm of effect of bb and hr on r over 57 years
# Teams1 %>%  
#   group_by(yearID) %>%
#   do(tidy(lm(R~BB+HR, data = .), conf.int = TRUE)) %>%
#   filter(term == "BB") %>% # pick the thing you want to see the effect of change over time (want to see how BB effects R over time)
#   select(yearID, estimate, conf.low, conf.high) %>%
#   ggplot(aes(yearID, y = estimate, ymin = conf.low, ymax = conf.high)) +  #ggplot  time
#   geom_errorbar() +
#   geom_point() +
#   geom_smooth(method = "lm", se = TRUE)



#get slope and pvalue of effect of bb on runs over 57 years?
fit = Teams1 %>%  
  group_by(yearID) %>%
  do(tidy(lm(R~BB+HR, data = .), conf.int = TRUE)) %>%
  filter(term == "BB") # pick the thing you want to see the effect of change over time (want to see how BB effects R over time)
  

tidy(lm(fit$estimate~fit$yearID, data=fit))