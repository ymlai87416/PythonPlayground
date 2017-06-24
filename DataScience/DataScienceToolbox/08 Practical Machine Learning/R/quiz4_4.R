library(lubridate)  # For year() function below
dat = read.csv("~/../Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

training <- training[,2:3]
testing <- testing[,2:3]
training$date <- as.Date(training$date)
testing$date <- as.Date(testing$date)
trainingTS <- xts(training$visitsTumblr, training$date)
testingTS <- xts(testing$visitsTumblr, testing$date)

fit <- bats(trainingTS, use.parallel=FALSE)
pred <- forecast(fit, h=235, level=95)
result <- sum(pred$lower < testing$visitsTumblr & pred$upper > testing$visitsTumblr)/235


