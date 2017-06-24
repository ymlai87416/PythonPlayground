library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)
#glm1 <- glm(chd~age+alcohol+obesity+tobacco+typea+ldl, family="binomial", data=trainSA)
glm1 <- train(chd~age+alcohol+obesity+tobacco+typea+ldl, method="glm",family="binomial", data=trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
predTest <- predict(glm1, newdata=trainSA)
predTest <- predict(glm1, newdata=testSA)
predTrain <- predict(glm1, newdata=trainSA)
outTest <- missClass(testSA$chd, predTest)
outTrain <- missClass(trainSA$chd, predTrain)