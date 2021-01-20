library(dslabs)
library(caret)
# # data(tissue_gene_expression)
# # dim(tissue_gene_expression$x)
# # table(tissue_gene_expression$y)
# # d <- dist(tissue_gene_expression$x)
# # ind <- c(1, 2, 39, 40, 73, 74)
# # as.matrix(d)[ind,ind]
# 
# set.seed(1, sample.kind = "Rounding") 
# 
# # test_index <- createDataPartition(y,times=1,p=0.5,list=FALSE)
# # train_set <- heights %>% slice(-test_index)
# # test_set <- heights %>% slice(test_index)
# # k = seq(1, 101, 3)
# # y = heights$sex
# # x = heights$height
# # 
# # fun = function(z) {
# #   knn_fit <- knn3(sex~height, data = train_set, k = z)
# #   y_hat_knn <- predict(knn_fit, test_set, type = "class") %>% factor()
# #   F_meas(y_hat_knn, test_set$sex)
# # }
# # 
# # f1_map = sapply(k, fun)
# # max(f1_map)
# library(dslabs)
# library(caret)
# data("tissue_gene_expression")
# 
# library(dslabs)
# library(caret)
# 
# data("tissue_gene_expression")
# 
# 
# set.seed(1, sample.kind = "Rounding")
# 
# 
# #someone elses code to test out
# # Create the index from the tissue names
# test_index <- createDataPartition(tissue_gene_expression$y, times = 1, p = 0.5, list = FALSE)
# 
# # Create training data
# y_train <- tissue_gene_expression$y[-test_index]
# x_train <- tissue_gene_expression$x[-test_index,]  # <---- Notice the comma
# 
# # Create test data
# y_test <- tissue_gene_expression$y[test_index]
# x_test <- tissue_gene_expression$x[test_index,] # <---- Notice the comma
# 
# # Not necessary, but for fun, lets put it back in the same format
# # as the original.  That is, a list of two. 
# train <- list(x=x_train, y=y_train)
# test  <- list(x=x_test,  y=y_test)
# 
# 
# 
# fun = function(z) {
#   knn_fit <- knn3(y~x, data = train, k = z)
#   y_hat_knn <- predict(knn_fit, test, type = "class") %>% factor()
#   confusionMatrix(y_hat_knn, test$y)$overall["Accuracy"]
# }
# 
# 
# k = seq(1, 11, 2)
# f1_map = sapply(k, fun)
# f1_map
# #max(f1_map)


library(tidyverse)
library(caret)

# set.seed(1996) #if you are using R 3.5 or earlier
# set.seed(1996, sample.kind="Rounding") #if you are using R 3.6 or later
# n <- 1000
# p <- 10000
# x <- matrix(rnorm(n*p), n, p)
# colnames(x) <- paste("x", 1:ncol(x), sep = "_")
# y <- rbinom(n, 1, 0.5) %>% factor()

# x_subset <- x[ ,sample(p, 100)]
# fit <- train(x_subset, y, method = "glm")
# fit$results

#install.packages("BiocManager")
#BiocManager::install("genefilter")


# library(genefilter)
# tt <- colttests(x, y)
# 
# pvals <- tt$p.value
# ind = pvals <.01
# 
# x_subset1 = x[,ind]
# fit <- train(x_subset1, y, method = "glm")
# fit$results

library(dslabs)
library(caret)

# data(mnist_27)
# set.seed(1995, sample.kind="Rounding") # if R 3.6 or later
# indexes <- createResample(mnist_27$train$y, 10)
# 
# x=sapply(indexes, function(ind){
#   sum(ind == 3)
# })
# sum(x)
# 
# y <- rnorm(100, 0, 1)
# quant = quantile(y, 0.75)
# 
# set.seed(1, sample.kind="Rounding")
# 
# rep = replicate(10000, {
#   y <- rnorm(100, 0, 1)
#   quant = quantile(y, 0.75)
#   quant
# })

set.seed(1, sample.kind = "Rounding") # if R 3.6 or later
y <- rnorm(100, 0, 1)
set.seed(1, sample.kind = "Rounding")
indexes <- createResample(y, 10000)

s1 = sapply(indexes, function(ind){
  quantile(y[ind], 0.75)
})

mean(s1)
sd(s1)