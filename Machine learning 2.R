library(caret)
data(iris)
iris <- iris[-which(iris$Species=='setosa'),]
y <- iris$Species


set.seed(2, sample.kind="Rounding") 
test_index <- createDataPartition(y,times=1,p=0.5,list=FALSE)
test <- iris[test_index,]
train <- iris[-test_index,]

current_feature_to_test = iris$Petal.Width #### NEED TO CHANGE LINE 16 WHEN YOU CHANGE THIS LINE TO TRAIN$ENTERCURENTFEATURE HERE!!!
cutoff = seq(min(current_feature_to_test), max(current_feature_to_test), .1)

accuracy = map_dbl(cutoff, function(x){
  y_hat = ifelse(train$Petal.Width > x, "virginica", "versicolor") %>%
    factor(levels = levels(test$Species))
  mean(y_hat == train$Species)
})
accuracy
max(accuracy) # find the cuttoff where the accuracy is the highest
accuracy==max(accuracy) # roundabout way to find the index of cutoff that makes this accuracy
bestcutoff1 = cutoff[18]
bestcutoff1 = 4.7 # just writing it out becuase i re run the same function but for a different factor
bestcutoff2 = cutoff[6]
bestcutoff2 = 1.5

#use best cutoff to see how our algoritghm works with our test data (after training it with our train data)
y_hat = ifelse(test$Petal.Width > bestcutoff, "virginica", "versicolor")%>%
  factor(levels = levels(test$Species))
mean(y_hat == test$Species)


#use 2 factors to predict test data -- two cuttoffs generated above from petal width and length
y_hat = ifelse(test$Petal.Length > bestcutoff1 | test$Petal.Width > bestcutoff2, "virginica", "versicolor")%>% # predict if either cutoff is exceeded
  factor(levels = levels(test$Species))
mean(y_hat == test$Species)
##accuracy goes down
