set.seed(3523)
library(AppliedPredictiveModeling)
library(elasticnet)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

object <- enet(as.matrix(training[,-9]), training$CompressiveStrength, lambda=0)
plot.enet(object)

