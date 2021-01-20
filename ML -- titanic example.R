library(titanic)    # loads titanic_train data frame
library(caret)
library(tidyverse)
library(rpart)


# 3 significant digits
options(digits = 3)

# clean the data - `titanic_train` is loaded with the titanic package
titanic_clean <- titanic_train %>%
  mutate(Survived = factor(Survived),
         Embarked = factor(Embarked),
         Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age), # NA age to median age
         FamilySize = SibSp + Parch + 1) %>%    # count family members
  select(Survived,  Sex, Pclass, Age, Fare, SibSp, Parch, FamilySize, Embarked)



#set.seed(42) # if using R 3.5 or earlier
set.seed(42, sample.kind = "Rounding") # if using R 3.6 or later
test_index <- createDataPartition(titanic_clean$Survived, times = 1, p = 0.2, list = FALSE) # create a 20% test set
test_set <- titanic_clean[test_index,]
train_set <- titanic_clean[-test_index,]

nrow(train_set)
nrow(titanic_clean)

set.seed(3, sample.kind = "Rounding")
y_hat = sample(c(0,1), nrow(test_set), replace = TRUE)

# y_hat
# mean(y_hat == test_set$Survived)
# 
# # f_train = filter(train_set, Sex == "male")
# # nrow(f_train)
# # f_train_surv = filter(f_train, Survived == "1")
# # nrow(f_train_surv)
# 
# # predict based on sex (female survive)
# y_hat<-ifelse(test_set$Sex=="female",1,0)
# mean(y_hat==test_set$Survived)
# 
# 
# train_set %>%
#   group_by(Pclass) %>%
#   summarize(Survived = mean(Survived == 1))
# 
# #predict based on class (first class survive)
# 
# y_hat = ifelse(test_set$Pclass == 1, 1,0)
# mean(y_hat == test_set$Survived)
# 
# 
# train_set %>%
#   group_by(Pclass, Sex) %>%
#   summarize(Survived = mean(Survived == 1))
# 
# 
# #predict based on class + sex(first & second class female survive)
# 
# y_hat = ifelse(test_set$Sex == "female" & test_set$Pclass %in% c(1,2), 1,0) %>% factor()
# mean(y_hat == test_set$Survived)
# 
# 
# #confusionMatrix(y_hat, test_set$Survived)
# 
# F_meas(y_hat, test_set$Survived)



#set.seed(1, sample.kind = "Rounding")


# 
# lda = train(Survived ~ Fare, method = "lda", data = train_set)
# y_hat_lda = predict(lda, test_set)
# confusionMatrix(y_hat_lda, test_set$Survived)
# 
# qda = train(Survived ~ Fare, method = "qda", data = train_set)
# y_hat_qda = predict(qda, test_set)
# confusionMatrix(y_hat_qda, test_set$Survived)
# 
# 
# ##glm using age as predicor
# 
# glm = train(Survived ~ ., method = "glm", data = train_set)
# y_hat_glm = predict(glm, test_set)
# confusionMatrix(y_hat_glm, test_set$Survived)


# set.seed(6, sample.kind = "Rounding")
# 
# knn_train = train(Survived ~ ., method = "knn", tuneGrid = data.frame(k = seq(3, 51, 2)), data = train_set)
# y_hat_knn = predict(knn_train, test_set)
# confusionMatrix(y_hat_knn, test_set$Survived)
# 
# ggplot(knn_train)


##Another way of doing it

# train_knn <- train(Survived ~ .,
#                    method = "knn",
#                    data = train_set,
#                    tuneGrid = data.frame(k = seq(3, 51, 2)))
# train_knn$bestTune

##trying the above again but with different training control -- 10 fold cross valadation

# set.seed(8, sample.kind = "Rounding")
# 
# ## set 10 fold cross valadation (cv)
# trControl <- trainControl(method  = "cv", number  = 10 )
# 
# knn_train = train(Survived ~ ., method = "knn", trControl  = trControl, tuneGrid = data.frame(k = seq(3, 51, 2)), data = train_set)
# y_hat_knn = predict(knn_train, test_set)
# confusionMatrix(y_hat_knn, test_set$Survived)
# 
# ggplot(knn_train)



# 
# set.seed(10, sample.kind = "Rounding")
# 
# ## same excersize but with tree method this time
# rpart_train = train(Survived ~ ., method = "rpart", tuneGrid = data.frame(cp = seq(0, 0.05, 0.002)), data = train_set)
# y_hat_rpart = predict(rpart_train, test_set)
# confusionMatrix(y_hat_rpart, test_set$Survived)
# 
# rpart_train$bestTune
# 
# ggplot(rpart_train)
# 

# #best decision tree after training -- use rpart instead of train(becuase we already trained and got cp) (using cp = 0.016)
# rpart_train_final = rpart(Survived ~ ., cp = .016, data = train_set)
# 
# #plot to see what varriables are used
# plot(rpart_train_final, mar = .2)
# text(rpart_train_final, cex = .75)

# # other way of doing it ___ try this out -- this does the same thing as my above code where i hard coded cp = .016 in
# rpart_train$finalModel # inspect final model
# 
# # make plot of decision tree
# plot(rpart_train$finalModel, margin = 0.1)
# text(rpart_train$finalModel)




## random forrest method

set.seed(14, sample.kind = "Rounding")

rf_train = train(Survived ~ ., method = "rf", tuneGrid = data.frame(mtry = seq(1:7)), ntree = 100, data = train_set)
y_hat_rf = predict(rf_train, test_set)
confusionMatrix(y_hat_rf, test_set$Survived)

rf_train$bestTune

ggplot(rpart_train)

varImp(rf_train) # find the most important varriables