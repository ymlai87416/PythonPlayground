library(RCurl)
trainURL <- getURL("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", ssl.verifypeer=FALSE)
training <- read.csv(text = trainURL)
testURL <- getURL("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", ssl.verifypeer=FALSE)
testing <- read.csv(text = testURL)

#preprocess by selecting features
#select feature which does not return NA for most values
selectFeatures <- c(8,9,10,11,37,38,39,40,41,42,43,44,45,46,47,48,49,60,61,62,63,64,65,66,67,68,84,85,86,102,113,114,115,116,117,118,119,120,121,122,123,124,140,151,152,153,154,155,156,157,158,159)
trainingPCA <- training[, selectFeatures]
for(i in seq_len(ncol(trainingPCA))){
  trainingPCA[, i] <- as.numeric(as.character(trainingPCA[, i]))
}
testingPCA <- testing[, selectFeatures]

#for my checking


#do PCA analysis
library(caret)
preProc <- preProcess(trainingPCA, method="pca")
trainingPCA <- predict(preProc, trainingPCA)
testingPCA <- predict(preProc, testingPCA)

#Random tree model
set.seed(32323)
trainingSet <- cbind(trainingPCA, classe=training[,classeIndex])
samples <- sample(19622, 80, replace=FALSE)
samplesTraining <- trainingSet[samples,]


#K fold for testing random tree
set.seed(32323)
folds <- createFolds(y=samplesTraining[, 26], k=10, list=TRUE, returnTrain=TRUE)
resultRF <- c()
for(i in 1:10){
  foldTrain <- samplesTraining[unlist(folds[i]),]
  foldTest <- samplesTraining[-unlist(folds[i]),]
  modelRF <- train(y=as.factor(foldTrain[, 26]), 
                   x=foldTrain[, 1:25], 
                   method='rf', prox=TRUE)
  preds <- predict(modelRF, foldTest[, 1:25])
  levels(preds) <- c('A', 'B', 'C', 'D', 'E')
  cm <- table(preds,foldTest[,26])
  acc <- (cm[1,1]+cm[2,2]+cm[3,3]+cm[4,4]+cm[5,5])/sum(cm)
  resultRF <- c(resultRF, acc)
}

#K fold for testing Naive Bayes
set.seed(32323)
folds <- createFolds(y=samplesTraining[, 26], k=10, list=TRUE, returnTrain=TRUE)
resultNB <- c()
for(i in 1:10){
  foldTrain <- samplesTraining[unlist(folds[i]),]
  foldTest <- samplesTraining[-unlist(folds[i]),]
  modelNB <- train(y=as.factor(foldTrain[, 26]), 
                   x=foldTrain[, 1:25], 
                   method='nb')
  preds <- predict(modelNB, foldTest[, 1:25])
  levels(preds) <- c('A', 'B', 'C', 'D', 'E')
  cm <- table(preds,foldTest[,26])
  acc <- (cm[1,1]+cm[2,2]+cm[3,3]+cm[4,4]+cm[5,5])/sum(cm)
  resultNB <- c(resultNB, acc)
}

#K fold for testing decision tree
set.seed(32323)
folds <- createFolds(y=samplesTraining[, 26], k=10, list=TRUE, returnTrain=TRUE)
resultRpart <- c()
for(i in 1:10){
  foldTrain <- samplesTraining[unlist(folds[i]),]
  foldTest <- samplesTraining[-unlist(folds[i]),]
  modelRPART <- train(y=as.factor(foldTrain[, 26]), 
                   x=foldTrain[, 1:25], 
                   method='rpart')
  preds <- predict(modelRPART, foldTest[, 1:25])
  levels(preds) <- c('A', 'B', 'C', 'D', 'E')
  cm <- table(preds,foldTest[,26])
  acc <- (cm[1,1]+cm[2,2]+cm[3,3]+cm[4,4]+cm[5,5])/sum(cm)
  resultRpart <- c(resultRpart, acc)
}


#K fold for testing support vector machine
set.seed(32323)
folds <- createFolds(y=samplesTraining[, 26], k=10, list=TRUE, returnTrain=TRUE)
resultSVM <- c()
for(i in 1:10){
  foldTrain <- samplesTraining[unlist(folds[i]),]
  foldTest <- samplesTraining[-unlist(folds[i]),]
  modelSVM <- svm(foldTrain[, 1:25], as.factor(foldTrain[, 26]))   
  preds <- predict(modelSVM, foldTest[, 1:25])
  levels(preds) <- c('A', 'B', 'C', 'D', 'E')
  cm <- table(preds,foldTest[,26])
  acc <- (cm[1,1]+cm[2,2]+cm[3,3]+cm[4,4]+cm[5,5])/sum(cm)
  resultSVM <- c(resultSVM, acc)
}



#testing model
test <- predict(modelNB, cbind(as.numeric(samplesTraining[, 1]), as.numeric(samplesTraining[, 2])))
levels(test) <- c('A', 'B', 'C', 'D', 'E')
confusionMatrix(test,samplesTraining[,3] )

test <- predict(modelGBM, cbind(as.numeric(samplesTraining[, 1]), as.numeric(samplesTraining[, 2])))
table(test,samplesTraining[,3] )

test <- predict(modelRF, samplesTraining[, 1:25])
levels(test) <- c('A', 'B', 'C', 'D', 'E')
confusionMatrix(test,samplesTraining[,26] )
table(test,samplesTraining[,26] )

test <- predict(modelRPART, samplesTraining[, 1:25])
levels(test) <- c('A', 'B', 'C', 'D', 'E')
confusionMatrix(test,samplesTraining[,26] )
table(test,samplesTraining[,26] )

## Try to do the submission first
test <- predict(modelRF, testingPCA[, 1:25])
pml_write_files(test)

