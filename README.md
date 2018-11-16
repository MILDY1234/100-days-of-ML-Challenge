# 100-days-of-ML-Challenge
100 days of Machine Learning coding challenge as proposed by Siraj Raval

## Day 1: Exploring and Understanding data

### Measuring spread – variance and standard deviation

Distributions allow us to characterize a large number of values using a smaller number of parameters. The normal distribution, which describes many types of real-world data, can be defined with just two: center and spread. The center of normal distribution is defined by its mean value, which we have used earlier. The spread is measured by a statistic called the standard deviation.In order to calculate the standard deviation, we must first obtain the variance, which is defined as the average of the squared differences between each value and the mean value. In mathematical notation, the variance of a set of n values of x is defined by the following formula. The Greek letter mu (similar in appearance to an m or u) denotes the mean of the values, and the variance itself is denoted by the Greek letter sigma squared (similar to a b turned sideways).

The standard deviation can be used to quickly estimate how extreme a given value is under the assumption that it came from a normal distribution. The 68-95-99.7 rule states that 68 percent of the values in a normal distribution fall within one standard deviation of the mean, while 95 percent and 99.7 percent of the values fall within two and three standard deviations, respectively. 

Applying this information to the used car data, we know that since the mean and standard deviation of price were $12,962 and $3,122, respectively, assuming that the prices are normally distributed, approximately 68 percent of cars in our data were advertised at prices between $12,962 - $3,122 = $9,840 and $12,962 + $3,122 = $16,804.

In the scatterplot we obtained via the code(in folder: Day1), the relationship we found between car prices and mileage is known as a negative association, because it forms a pattern of dots in a line sloping downward. A positive association would appear to form a line sloping upward. A flat line, or a seemingly random scattering of dots, is evidence that the two variables are not associated at all. The strength of a linear association between two variables is measured by a statistic known as correlation.

### Two-way cross-tabulations: Examining Relationships

To examine a relationship between two nominal variables, a two-way cross-tabulation is used (also known as a crosstab or contingency table). A cross-tabulation is similar to a scatterplot in that it allows us to examine how the values of one variable vary by the values of another. The format is a table in which the rows are the levels of one variable, while the columns are the levels of another.

There is a wealth of data in the CrossTable() output. The legend at the top (labeled Cell Contents) indicates how to interpret each value. The rows in the table indicate the three models of used cars: SE, SEL, and SES (plus an additional row for the total across all models). The columns indicate whether or not the car's color is conservative (plus a column totaling across both types of color). The first value in each cell indicates the number of cars with that combination of model and color. The proportions indicate that the cell's proportion is relative to the chi-square statistic, row's total, column's total, and table's total.What we are most interested in is the row proportion for conservative cars for each model. The row proportions tell us that 0.654 (65 percent) of SE cars are colored conservatively in comparison to 0.696 (70 percent) of SEL cars and 0.653 (65 percent) of SES. These differences are relatively small, suggesting that there are no substantial differences in the types of colors chosen by the model of the car.


## Day 2:

### Lazy Learning: Nearest Neighbour 

Its a method to measure the similarity of two examples using distance. Despite the simplicity of this idea, nearest neighbor methods are extremely powerful. They have been used successfully for:
1. Computer vision applications, including optical character recognition and facial recognition in both still images and video
2. Predicting whether a person will enjoy a movie or music recommendation
3. Identifying patterns in genetic data, perhaps to use them in detecting specific proteins or diseases

The k-NN algorithm treats the features as coordinates in a multidimensional feature space. Traditionally, the k-NN algorithm uses Euclidean distance, which is the distance one would measure if it were possible to use a ruler to connect two points.
Euclidean distance is specified by the following formula, where p and q are the examples to be compared, each having n features. The term p1 refers to the value of the first feature of example p, while q1 refers to the value of the first feature of example q:

dist(p,q)=sqrt[(p1-q1)^2+(p2-q1)^2+....+(pn-qn)^2]

### Choosing an appropriate k

The decision of how many neighbors to use for k-NN determines how well the model will generalize to future data. The balance between overfitting and underfitting the training data is a problem known as bias-variance tradeoff. 
In practice, choosing k depends on the difficulty of the concept to be learned, and the number of records in the training data. One common practice is to begin with k equal to the square root of the number of training examples. 
An alternative approach is to test several k values on a variety of test datasets and choose the one that delivers the best classification performance. 

Classification algorithms based on the nearest neighbor methods are considered lazy learning algorithms because, technically speaking, no abstraction occurs.

## Day 3:

### Diagnosing breast cancer with the k-NN algorithm

During regular examinations, the sample cells are extracted from the mass and examined. If machine learning could automate the identification of cancerous cells, it would provide considerable benefit to the health system. Automated processes are likely to improve the efficiency of the detection process, allowing physicians to spend less time diagnosing and more time treating the disease. 

### Step 1 – collecting data
We will utilize the Wisconsin Breast Cancer Diagnostic dataset from the UCI Machine Learning Repository at http://archive.ics.uci.edu/ml.

### Step 2 – exploring and preparing the data
TRANSFORMATION – NORMALIZING NUMERIC DATA:
To normalize these features, we need to create a normalize() function in R. This function takes a vector x of numeric values, and for each value in x, subtracts the minimum value in x and divides by the range of values in x. Finally, the resulting vector is returned.

### Step 3 – training a model on the data
The knn() function in the class package provides a standard, classic implementation of the k-NN algorithm. For each instance in the test data, the function will identify the k-Nearest Neighbors, using Euclidean distance, where k is a user-specified number. 

### Step 4 – evaluating model performance
The next step of the process is to evaluate how well the predicted classes in the wbcd_test_pred vector match up with the known values in the wbcd_test_labels vector. We will use CrossTable() function in the gmodels package.

### Step 5 – improving model performance
Transformation – z-score standardization
To standardize a vector, we can use the R's built-in scale() function, which, by default, rescales values using the z-score standardization. The scale() function offers the additional benefit that it can be applied directly to a data frame, so we can avoid the use of the lapply() function.

### Testing alternative values of K
We may be able do even better by examining performance across various k values. Using the normalized training and test datasets, the same 100 records were classified using several different k values. 

## Day 4:

## Classification using Naive Bayes

An example to it could be Weather estimates based on probabilistic methods. They are based on past events to predict future events. A 70% chance of rain implies rain occured in 7 out of 10 past cases with similar conditions.

Thomas Bayes develped foundation principles to describe probability of events and how it should be revised in light of additional information. These principles are known as Bayesian methods.

Probability is a number between 0 and 1 (that is, between 0 percent and 100 percent), which captures the chance that an event will occur in the light of the available evidence. A probability of 0 indicates that the event will definitely not occur, while a probability of 1 indicates that the event will occur with 100 percent certainty.

Bayesian classifiers have been used for:

Text classification, such as junk e-mail (spam) filtering
Intrusion or anomaly detection in computer networks
Diagnosing medical conditions given a set of observed symptoms

Bayesian methods provide insights into how the probability of any event can be estimated from the observed data.

If it rained 3 out of 10 days the probability of rains could be estimated as 3/10=0.30 or 30%. Similarly if 10 out of 50 emails were spam the probability of any incoming messages being spam can be estimated to be 10/50=0.20 or 20%

Hence to denote P which is probability of an event P(rain)=0.30 and P(spam)=0.20

P(spam)=0.20 and P(ham)=1-0.20=0.80

## Day 5: 

### Filtering mobile phone spam using Naive Bayes algorithm

### Step 1 - Collecting the data

To develop the Naive Bayes classifier, we will use data adapted from the SMS Spam Collection at http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/

### Step 2 - Exploring and Preparing the data

Using the str() function, we see that the sms_raw data frame includes 5,559 total SMS messages with two features: type and text. The SMS type has been coded as either ham or spam. The text element stores the full raw SMS text.

The type element is currently a character vector. Since this is a categorical variable, it would be better to convert it into a factor.

One needs to consider how to remove numbers and punctuation; handle uninteresting words such as and, but, and or; and how to break apart sentences into individual words. We will use the 'tm' package for data cleaning and preparation.

The first step in processing text data involves creating a corpus, which is a collection of text documents. The documents can be short or long, from individual news articles, pages in a book or on the web, or entire books. In our case, the corpus will be a collection of SMS messages.

In order to create a corpus, we'll use the VCorpus() function in the tm package, which refers to a volatile corpus—volatile as it is stored in memory as opposed to being stored on disk (the PCorpus() function can be used to access a permanent corpus stored in a database)

In order to perform our analysis, we need to divide these messages into individual words. But first, we need to clean the text, in order to standardize the words, by removing punctuation and other characters that clutter the result. For example, we would like the strings Hello!, HELLO, and hello to be counted as instances of the same word.The tm_map() function provides a method to apply a transformation (also known as mapping) to a tm corpus. We will use this function to clean up our corpus using a series of transformations and save the result in a new object called corpus_clean.







