hair_eye = as.data.frame(HairEyeColor)
r2 <- rPlot(Freq ~ Hair | Eye, color='Eye', data=hair_eye, type='bar')
r2$save('fig/r2.html', cdn=TRUE)
cat('<iframe src="fig/r2.html" width=100%, height=600></iframe>')