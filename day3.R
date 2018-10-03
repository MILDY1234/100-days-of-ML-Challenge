##Day 3: Diagnosing breast cancer with the k-NN algorithm

wbcd <- read.csv("C:/Users/prasadvi/Downloads/Machine learning with R sample codes/MLwR-master/Machine Learning with R (2nd Ed.)/Chapter 03/wisc_bc_data.csv", stringsAsFactors=FALSE)
View(wbcd)
str(wbcd)

#Dropping the ID column as it gives no valuable information
wbcd<-wbcd[-1]
table(wbcd$diagnosis)
wbcd$diagnosis<- factor(wbcd$diagnosis, levels=c("B","M"),labels=c("Benign","Malignant"))
table(wbcd$diagnosis)

#Calculating percentage
round(prop.table(table(wbcd$diagnosis)) * 100, digits=1)
summary(wbcd[c("radius_mean","area_mean","smoothness_mean")])

#Since smoothness ranges from 0.05 to 0.16 and area ranges from 143.5 to 2501.0, 
#the impact of area is going to be much larger than the smoothness in the distance
#calculation. This could potentially cause problems for our classifier,
#so let's apply normalization to rescale the features to a standard range of values.

#Creating a normalize function now

normalize <- function(x) {       return ((x - min(x)) / (max(x) - min(x)))}

#Testing now
normalize(c(1,2,3,4,5,6,7,8,9))
normalize(c(10,20,30,40,50,60,70,80,90))

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_n$area_mean)
#area_mean variable, which originally ranged from 143.5 to 2501.0, now ranges from 0 to 1

#Data preparation: Creating training and test datasets
wbcd_train<-wbcd_n[1:469, ]
wbcd_test<-wbcd_n[470:569,] #blank value indicates all rows & columns should be included
wbcd_train_labels<-wbcd[1:469, 1]
wbcd_test_labels<-wbcd[470:569,1]

#We will install k-NN package to 
install.packages("class")
library("class")

#knn function provides a standard, classic implementation of the k-NN algorithm.
#As our training data includes 469 instances, we might try k = 21, 
#an odd number roughly equal to the square root of 469.

wbcd_test_pred<-knn(train = wbcd_train, test= wbcd_test, cl=wbcd_train_labels, k=21)

#The next step of the process is to evaluate how well the predicted classes in the 
#wbcd_test_pred vector match up with the known values in the wbcd_test_labels vector. 

library(gmodels)
CrossTable(x=wbcd_test_labels, y=wbcd_test_pred, prop.chisq = FALSE)

#A total of 2 out of 100, or 2 percent of masses were incorrectly classified by the k-NN approach.
#Now improving model performance using z-score standardization
wbcd_z <- as.data.frame(scale(wbcd[-1]))

#This command rescales all the features, with the exception of diagnosis and stores the result as
#the wbcd_z data frame. The _z suffix is a reminder that the values were z-score transformed.

summary(wbcd_z$area_mean)

#Repeating the process to see the change

wbcd_train<-wbcd_z[1:469, ]
wbcd_test<-wbcd_z[470:569,]
wbcd_train_labels<-wbcd[1:469, 1]
wbcd_test_labels<-wbcd[470:569,1]
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,cl = wbcd_train_labels, k = 21)
CrossTable(x=wbcd_test_labels, y=wbcd_test_pred, prop.chisq = FALSE)

#Unfortunately, in the following table, the results of our new transformation show a 
#slight decline in accuracy.
#We may be able do even better by examining performance across various k values.
