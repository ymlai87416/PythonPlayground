library(ElemStatLearn)
library(caret)
data(vowel.train)
data(vowel.test) 

vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)

set.seed(33833)

fitrf <- train(y~., data=vowel.train, method="rf", verbose=FALSE)
fitgbm <- train(y~., data=vowel.train, method="gbm", verbose=FALSE)

predictRf <- predict(fitrf, newdata=vowel.test)
predictGbm <- predict(fitgbm, newdata=vowel.test)

confusionMatrix(predictRf, vowel.test$y)
confusionMatrix(predictGbm, vowel.test$y)
confusionMatrix(predictRf, predictGbm)