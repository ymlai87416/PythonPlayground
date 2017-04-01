library(caret);
data(faithful)
set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)
trainFaith <- faithful[inTrain, ]
testFaith <- faithful[-inTrain, ]
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="Waiting", ylab="Duration")
lm1 <- lm(eruptions ~ waiting, data=trainFaith)
lines(trainFaith$waiting, lm1$fitted, lwd=3)

pred1 <- predict(lm1, newdata=testFaith, interval='prediction')
ord <- order(testFaith$waiting)
plot(testFaith$waiting, testFaith$eruptions, pch=19, col='blue')
matlines(testFaith$waiting[ord], pred1[ord], type='l', col=c(1,2,2), lty=c(1,1,1), lwd=3)

