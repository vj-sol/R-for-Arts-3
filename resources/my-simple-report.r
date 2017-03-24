##title: My short analysis
##author: Vijay

# First we load the packages
library(tidyr)
library(ggplot2)
library(Hmisc)
library(psych)

pers_exp <- USPersonalExpenditure

# Let's look at the data
pers_exp	#it looks like the row names are not actually in the matrix
		#let's fix that

expenditure_type <- rownames(pers_exp)
expenditure_type <- gsub( ' ' , '_' , expenditure_type) # Replace spaces with underscores
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

# We should now look at some descriptive stats
# Let's use the describe function from the psych package
psych::describe(pers_exp)

# Okay, that's nice but we really just want the Private Education info

psych::describe(pers_exp$Private_Education)

# This shows a difference between the minumum and maximum values
# with both the mean and median roughly in between.
# This would suggest a general change, but we cannot be sure of the direction.
# A plot might help with this

# Plot private education over time
ggplot( pers_exp , aes( year , Private_Education))+
	geom_bar(stat='identity')+
	labs( x = 'Year' , y = 'Expenditure on private education\nin billions of $') +
	theme_classic()
# This plot shows that expenditure on Private Education has
# increased between 1940 and 1960.

# Let's now see if the correlation between these values is significant

# First calculate correlation and p-value
cor_vals <- rcorr( pers_exp$year , pers_exp$Private_Education )

# Straight up scatter plot
ggplot( pers_exp , aes( x = as.numeric(year) , y = Private_Education)) +
  geom_point() +
  geom_smooth(method='lm') +
  annotate('text' , x = 1945 , y = 3.2 ,
    label = paste('R^2 == ' , round(cor_vals$r[1,2],3) , sep=''), parse = T) +
  annotate('text' , x = 1945 , y = 3 ,
    label = paste('p ==', round(cor_vals$P[1,2],5) , sep=''), parse = T) +
  labs(x = 'Year' , y = 'Expenditure on private education\nin billions of $') +
  theme_classic()

# Bar plot with scatter plot overlay
ggplot( pers_exp , aes( x = as.numeric(year) , y = Private_Education)) +
  geom_bar(stat='identity')+
  geom_point() +
  geom_smooth(method='lm') +
  annotate('text' , x = 1945 , y = 3.2 ,
    label = paste('R^2 == ' , round(cor_vals$r[1,2],3) , sep=''), parse = T) +
  annotate('text' , x = 1945 , y = 3 ,
    label = paste('p ==', round(cor_vals$P[1,2],5) , sep=''), parse = T) +
  labs(x = 'Year' , y = 'Expenditure on private education\nin billions of $') +
  theme_classic()
