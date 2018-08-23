# 100-days-of-ML-Challenge
100 days of Machine Learning coding challenge as proposed by Siraj Raval

Day 1: Exploring and Understanding data

Measuring spread – variance and standard deviation

Distributions allow us to characterize a large number of values using a smaller number of parameters. The normal distribution, which describes many types of real-world data, can be defined with just two: center and spread. The center of normal distribution is defined by its mean value, which we have used earlier. The spread is measured by a statistic called the standard deviation.In order to calculate the standard deviation, we must first obtain the variance, which is defined as the average of the squared differences between each value and the mean value. In mathematical notation, the variance of a set of n values of x is defined by the following formula. The Greek letter mu (similar in appearance to an m or u) denotes the mean of the values, and the variance itself is denoted by the Greek letter sigma squared (similar to a b turned sideways).

The standard deviation can be used to quickly estimate how extreme a given value is under the assumption that it came from a normal distribution. The 68-95-99.7 rule states that 68 percent of the values in a normal distribution fall within one standard deviation of the mean, while 95 percent and 99.7 percent of the values fall within two and three standard deviations, respectively. 

Applying this information to the used car data, we know that since the mean and standard deviation of price were $12,962 and $3,122, respectively, assuming that the prices are normally distributed, approximately 68 percent of cars in our data were advertised at prices between $12,962 - $3,122 = $9,840 and $12,962 + $3,122 = $16,804.

In the scatterplot we obtained via the code(in folder: Day1), the relationship we found between car prices and mileage is known as a negative association, because it forms a pattern of dots in a line sloping downward. A positive association would appear to form a line sloping upward. A flat line, or a seemingly random scattering of dots, is evidence that the two variables are not associated at all. The strength of a linear association between two variables is measured by a statistic known as correlation.

Two-way cross-tabulations: Examining Relationships

To examine a relationship between two nominal variables, a two-way cross-tabulation is used (also known as a crosstab or contingency table). A cross-tabulation is similar to a scatterplot in that it allows us to examine how the values of one variable vary by the values of another. The format is a table in which the rows are the levels of one variable, while the columns are the levels of another.
