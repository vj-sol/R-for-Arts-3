##title: Check out my fancy report
##author: Vijay

## Here is some text
library(ggplot2)
ggplot(mtcars,aes(mpg,hp,colour=as.factor(gear)))+
	geom_point()
#' Here is more text
