sms_raw<-read.csv("sms_spam.csv", stringsAsFactors=FALSE)
View(sms_raw)
str(sms_raw)
#converting the type row to factor
sms_raw$type<-factor(sms_raw$type)
str(sms_raw$type)
table(sms_raw$type)

#Data preparation: Cleaning and standardizing text data

#We will use 'tm' package to perform cleaning
install.packages("tm")
library(tm)
#Creating a corpus which is a collection of text documents
sms_corpus<-VCorpus(VectorSource(sms_raw$text))
print(sms_corpus)

#To receive a summary of specific messages, we can use the inspect() function with list operators. 

inspect(sms_corpus[1:2])
as.character(sms_corpus[[1]])
lapply(sms_corpus[1:2], as.character)
#We opt for transformation here to convert the instances of same word, eg Hello, HELLO and hello should be counted as same
sms_corpus_clean<-tm_map(sms_corpus, content_transformer(tolower))
#comparing the two now 
as.character((sms_corpus[[1]]))    
as.character((sms_corpus_clean[[1]]))    
#continuing the cleanup by removing numbers from the SMS
sms_corpus_clean<-tm_map(sms_corpus_clean, removeNumbers)
#removing filler/stop words like 'to,and,but,or' as they do not provide useful information for machine learning
#we remove any words that appear in the stop words list by using removeWords
sms_corpus_clean<-tm_map(sms_corpus_clean, removeWords, stopwords())
#now we remove any punctuations
sms_corpus_clean<-tm_map(sms_corpus_clean, removePunctuation)
#To work around the default behavior of removePunctuation(), simply create a custom function that replaces rather than removes punctuation characters
#i.e.,:> replacePunctuation <- function(x) {    gsub("[[:punct:]]+", " ", x)}
#we now proceed with stemming which takes words like learned, learning, learns and strips suffix to transform into learn
install.packages('SnowballC')
library(SnowballC)
wordStem(c("learn", "learned", "learning", "learns"))
sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)
#the final step in our text cleanup process is to remove additional whitespace, using the built-in stripWhitespace() transformation
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)
#the messages have been limited to the most interesting words, and punctuation and capitalization have been removed

#Data Preparation

#final step is to split the messages into individual components through a process called tokenization, here tokens are words
sms_dtm<-DocumentTermMatrix(sms_corpus_clean)

#instead of all the preprocessing steps, we can create DTM directly from raw, unprocessed SMS corpus

sms_dtm2<- DocumentTermMatrix(sms_corpus, control = list(tolower=TRUE, removeNumbers=TRUE, stopwords=TRUE, removePunctuation=TRUE, stemming=TRUE))

#creating training and test datasets
sms_dtm_train<- sms_dtm[1:4169,]
sms_dtm_test<-sms_dtm[4170:5559,]

sms_train_labels<-sms_raw[1:4169,]$type
sms_test_labels<-sms_raw[4170:5559,]$type
prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))
#both the training data and test data contain about 13 percent spam. This suggests that the spam messages were divided evenly between the two datasets.

#Visualizing the Text Data

install.packages("wordcloud")
library(wordcloud)
wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)

#now creating a cloud for spam and ham directly using sms_raw
spam<-subset(sms_raw, type=="spam")
ham<-subset(sms_raw, type=="ham")
wordcloud(spam$text, max.words=40, scale=c(3,0.5), random.order=FALSE)
wordcloud(ham$text, max.words=40, scale=c(3,0.5), random.order = FALSE)

findFreqTerms(sms_dtm_train,5)
sms_freq_words<-findFreqTerms(sms_dtm_train,5)
str(sms_freq_words)
sms_dtm_freq_train<-sms_dtm_train[, sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[, sms_freq_words]

convert_counts <- function(x) {    x <- ifelse(x > 0, "Yes", "No")  }
sms_train <- apply(sms_dtm_freq_train, MARGIN = 2,convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN = 2,convert_counts)
install.packages("e1071")
library(e1071)
sms_classifier<-naiveBayes(sms_train, sms_train_labels)
sms_test_pred<-predict(sms_classifier, sms_test)
library(gmodels)
CrossTable(sms_test_pred, sms_test_labels,    prop.chisq = FALSE, prop.t = FALSE,    dnn = c('predicted', 'actual'))

#improving model performance

#we didn't set a value for the Laplace estimator while training our model.
#This allows words that appeared in zero spam or zero ham messages to have an indisputable say in the classification process.

sms_classifier2<-naiveBayes(sms_train, sms_train_labels, laplace=1)
sms_test_pred2<-predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_test_labels, prop.chisq=FALSE, prop.t=FALSE, prop.r = FALSE, dnn=c('predicted','actual'))
