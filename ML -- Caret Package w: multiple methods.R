library(rpart)
library(ggplot2)
library(dslabs)
library(caret)
library(tidyverse)

set.seed(1991, sample.kind = "Rounding")

dat = dat <- data.frame(y = tissue_gene_expression$y , x = tissue_gene_expression$x)
# y1 = train(y ~ ., method = "rpart", data = dat, tuneGrid = data.frame(cp = seq(0, 0.1, 0.01)))
# ggplot(y1, highlight = TRUE)

#second time with more nodes
#y1 = train(y ~ ., method = "rpart", data = dat, control = rpart.control(minsplit = 0), tuneGrid = data.frame(cp = seq(0, 0.1, 0.01)))
#ggplot(y1, highlight = TRUE)

#confusionMatrix(y1)
#fit <- rpart(y ~ ., data = dat) 
# plot(fit)
# text(fit)

# fit <- with(tissue_gene_expression, 
#             train(x, y, method = "rf", 
#                   nodesize = 1,
#                   tuneGrid = data.frame(mtry = seq(50, 200, 25))))
# 
# ggplot(fit)

varImp(fit)

fit_rpart = train(y ~ ., method = "rpart", data = dat, control = rpart.control(minsplit = 0), tuneGrid = data.frame(cp = seq(0, 0.1, 0.01)))

tree_terms <- as.character(unique(fit_rpart$finalModel$frame$var[!(fit_rpart$finalModel$frame$var == "<leaf>")]))
tree_terms
