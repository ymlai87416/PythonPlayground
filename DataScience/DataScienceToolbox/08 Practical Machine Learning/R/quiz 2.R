library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
training2 <- training[, seq(58, 69)]
testing2 <- testing[, seq(58, 69)]
preProc <- preProcess(training2, method="pca", thresh=0.8)
trainingPC <- predict(preProc, training2)
testingPC <- predict(preProc, testing2)

modelFitNorm <- train(training$diagnosis~., method="glm", data=training2)
modelFitPCA <- train(training$diagnosis~., method="glm", data=trainingPC)

confusionMatrix(testing$diagnosis, predict(modelFitNorm, testing2))
confusionMatrix(testing$diagnosis, predict(modelFitPCA, testingPC))