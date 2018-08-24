usedcars<-read.csv("usedcars.csv", stringsAsFactors = FALSE)
str(usedcars)
summary(usedcars$year)
summary(usedcars[c("price","mile")])
range(usedcars$price)
diff(range(usedcars$price))
quantile(usedcars$price)
quantile(usedcars$price, probs=c(0.01,0.99))
quantile(usedcars$price, seq(from = 0, to = 1, by = 0.20))
summary(usedcars$price)
boxplot(usedcars$price, main="Boxplot of used car prices", ylab="Price ($)")
boxplot(usedcars$mileage, main="Boxplot of used car mileage", ylab="Odometer(mi.)")
hist(usedcars$price, main="Histogram of used car prices", xlab="Price($)")
hist(usedcars$mileage, main="Histogram of used car mileage", xlab="Mileage(ml.)")
var(usedcars$price)#calculates variance
sd(usedcars$price)
sd(usedcars$mileage)#calculates standard deviation
var(usedcars$mileage)
names(usedcars)
table(usedcars$year)
table(usedcars$model)
table(usedcars$color)
model.table<-table(usedcars$model)
model.table
prop.table(model.table) #Performs the table proportion calculation
#Now displaying the results in percentages with a single decimal place
color_table<-table(usedcars$color)
color_table
color_pot<-prop.table(color_table)*100
round(color_pot, digits=1)
#scatterplot
plot(x=usedcars$mileage, y= usedcars$price, main="Scatterplot of Price vs Mileage", xlab="Used car Odometer(mi.)", ylab="Used car Price($)")
#Examining Cross Relationship(two way cross tabulation)
install.packages("gmodels")
library(gmodels)
usedcars$conservative<-usedcars$color %in% c("Black","Gray","Silver", "White")
table(usedcars$conservative)
CrossTable(x=usedcars$model, y=usedcars$conservative, chisq = TRUE)
