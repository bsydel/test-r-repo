library(dslabs)
library(caret)
library(tidyverse)
data("tissue_gene_expression")

# set.seed(1993) #if using R 3.5 or earlier
set.seed(1993, sample.kind="Rounding") # if using R 3.6 or later
ind <- which(tissue_gene_expression$y %in% c("cerebellum", "hippocampus"))
y <- droplevels(tissue_gene_expression$y[ind])
x <- tissue_gene_expression$x[ind, ]
x <- x[, sample(ncol(x), 10)]

f1 = train(x,y, method = "lda", preProcess = "center")
f1
f1$finalModel$means

t(f1$finalModel$means) %>% data.frame() %>%
  mutate(predictor_name = rownames(.)) %>%
  ggplot(aes(cerebellum, hippocampus, label = predictor_name)) +
  geom_point() +
  geom_text() +
  geom_abline()



## same thing but with QDA instead of LDA

# library(dslabs)      
# library(caret)
# data("tissue_gene_expression")
# 
# set.seed(1993) #set.seed(1993, sample.kind="Rounding") if using R 3.6 or later
# ind <- which(tissue_gene_expression$y %in% c("cerebellum", "hippocampus"))
# y <- droplevels(tissue_gene_expression$y[ind])
# x <- tissue_gene_expression$x[ind, ]
# x <- x[, sample(ncol(x), 10)]
# 
# f1 = train(x,y, method = "qda")
# f1
# f1$finalModel$means
# 
# t(f1$finalModel$means) %>% data.frame() %>%
#   mutate(predictor_name = rownames(.)) %>%
#   ggplot(aes(cerebellum, hippocampus, label = predictor_name)) +
#   geom_point() +
#   geom_text() +
#   geom_abline()


library(dslabs)      
library(caret)
data("tissue_gene_expression")

# set.seed(1993) # if using R 3.5 or earlier
set.seed(1993, sample.kind="Rounding") # if using R 3.6 or later
y <- tissue_gene_expression$y
x <- tissue_gene_expression$x
x <- x[, sample(ncol(x), 10)]


f1 = train(x,y, method = "lda", preProcess = "center")
f1
f1$finalModel$means

