library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

training$diagnosis <- factor(training$diagnosis)

fitrf <- train(diagnosis~., training, method="rf", verbose=FALSE)
fitgbm <- train(diagnosis~., training, method="gbm", verbose=FALSE)
fitlda <- train(diagnosis~., training, method="lda", verbose=FALSE)

predRf <- predict(fitrf, testing)
predGbm <- predict(fitgbm, testing)
predLda <- predict(fitlda, testing)

predDF <- data.frame(predRf, predGbm, predLda, diagnosis=testing$diagnosis)
combModFit <- train(diagnosis~., method="rf", data=predDF)
combPred <- predict(combModFit, predDF)

confusionMatrix(predRf, testing$diagnosis)
confusionMatrix(predGbm, testing$diagnosis)
confusionMatrix(predLda, testing$diagnosis)
confusionMatrix(combPred, testing$diagnosis)