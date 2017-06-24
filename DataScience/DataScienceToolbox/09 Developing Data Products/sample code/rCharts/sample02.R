names(iris) = gsub("\\.", "", names(iris))
r1 <- rPlot(SepalLength ~ SepalWidth | Species, data=iris, color='Species', type='point')
r1$save('fig/r1.html', cdn=TRUE)
cat('<iframe src="fig/r1.html" width=100%, height=600></iframe>')