library(Lahman)
library(dslabs)
library(broom)
library(tidyverse)
library(tidyr)
library(dplyr)
library(HistData)
data("GaltonFamilies")
set.seed(1) # if you are using R 3.5 or earlier
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>% 
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
  unite(pair, c("parent", "child"))

# dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
#   mutate(HR = HR/G,R = R/G) %>%
#   select(lgID, HR, BB, R) 
# 
# 
# dat %>% 
#   group_by(lgID) %>% 
#   do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
#   filter(term == "HR") 




galton %>%
  group_by(pair) %>%
  do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = T)) %>% filter(term == "parentHeight") %>%
  ggplot(aes(pair, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar() +
  geom_point()


