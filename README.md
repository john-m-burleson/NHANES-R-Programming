National Health and Nutrition Examination Survey (NHANES) R-programming 
===

![nhanes](https://user-images.githubusercontent.com/36578867/47465145-7a378c00-d7a0-11e8-99a5-bf53ead6d80b.jpg)

Here is a Link to the NHANES website so you can first learn about this data repository:
[NHANES Homepage]( https://www.cdc.gov/nchs/nhanes/)

*A understanding of their metadata repository is highly encourged*

**Who can benifit from this code repository?**

This is to help anybody that would like to conduct research using the  *National Health and Nutrition Examination Survey (NHANES)* data repository using R. In this project we go from: downloading our data directly from the NHANES data repository, using a R package called *RNHANES* , to cleaning our data, imputing missing values using a R package called  *mi*, providing descriptive statistics with graphics, and using logistic regression to try and forecast our results. 

 **SQL R nhanes 1999-2018 walking impairment**

This file downloads raw data files from 1999-2018 and merges them into a "master" file that is the first start to any research project(After a proper literature review!); NHANES breaks down their data into years and within each year they further break down their datasets into questions that are similar to one another. This is useful once you can navigate the site and once you get a thorough understanding of their metadata repository. We join our different datasets using basic SQL commands and output our datafile as a CSV file so we can impute missing values.One thing to note is that if you want do not wish to impute missing values then we can just omit any rows that have at least one missing value by using the R command “na.omit()”.

** Note: The RNAHNES package losses suppourt after the year 2014, so we have to manually download SAS files and work with these files within the R enviorment.



**Descriptive statistics/Inferential Statistics/ Graphics using ggplot2**

In this file we conduct statistical inference in the form of: Chi- square test of equal proportions, Chi-square test of independence and we create a correlation matrix of all variables in our dataset. We also wish to summarize our dataset in the form of descriptive statistics; we do this by visualizing our dataset in the form of waffle plots (square pie charts) and box plots using ggplot2.

Here are some of examples of data vizualizations that we will create using this code:

![figure1h_walking impairment](https://user-images.githubusercontent.com/36578867/47458750-3720ed00-d78f-11e8-8e19-1d3e3f72b32f.jpg)

*waffle plot*

![figure2_correlation_matrix](https://user-images.githubusercontent.com/36578867/47458832-6b94a900-d78f-11e8-9bd6-d0a99c29e5f3.jpg)

![figure1a_age](https://user-images.githubusercontent.com/36578867/47587368-81cd7100-d917-11e8-9908-e80ded1ef3bc.jpg)

**Logistic regression**

In this file we conduct binary logistic regression to try and forecast the odds of a person experiencing walking impairment in their lifetime. Our logistic regression model is a function of other possible dependent demographic variables that represent our population of interest. These variables are associated with walking impairment, such as diabetes and gender. These variables are important because having one or more of these characteristics increases the odds of you having walking impairment in your lifetime. We come up with a statistically significant model as well as provide some model performance metrics Such as a ROC curve (as seen below) to gauge the predictability of our model.

![figure3_roc_curve](https://user-images.githubusercontent.com/36578867/47459487-10fc4c80-d791-11e8-8edc-414675fb0af2.jpg)


**Machine learning models/ General Linear Model**

In these files we try and put together some machine learning models and one GLM and try and predict walking impairment in an individual. 
These models include:

*1) Decision Trees*

*2) Neural Networks*

*3) Random Forrest (partykit R:package)*

*4) Random Forrst*

*5) General Linear model: Ordinal Logistic Regression*





