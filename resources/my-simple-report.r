##title: My short analysis
##author: Vijay

# First we load the packages
library(tidyr)
library(ggplot2)

pers_exp <- USPersonalExpenditure

# Let's look at the data
pers_exp	#it looks like the row names are not actually in the matrix
		#let's fix that

expenditure_type <- rownames(pers_exp)
expenditure_type <- gsub( ' ' , '_' , expenditure_type)
rownames(pers_exp) <- NULL
pers_exp <- as.data.frame(pers_exp)
pers_exp <- cbind(expenditure_type,pers_exp)

# Let's look at the data now
pers_exp	#better, but it doesn't look tidy to me
		#let's fix that


pers_exp <- gather( pers_exp , `1940` , `1945` , `1950` , `1955` , `1960` , 
	key = year, value =  expenditure)
pers_exp <- spread( pers_exp , key = expenditure_type , value = expenditure)

# Let's look at the data now
pers_exp	#better


# Plot private education over time
ggplot( pers_exp , aes( year , Private_Education))+
	geom_bar(stat='identity')+
	labs( x = 'Year' , y = 'Expenditure on private education\nin billions of $') +
	theme_classic()
