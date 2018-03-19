# NHANES-project
Hello world!

First I would like to say that this project is an attempt to help anybody that would like to conduct research using the 
National Health and Nutrition Examination Survey (NHANES) data repository using R. In this project we go from: downloading our data directly from 
the NHANES website using a R package called "RNHANES", to cleaning our data, imputing missing values using a R package called "mi",
providing some descriptive statistics with graphics, and using logistic regression to try and forecast our results. 



Here is a small introduction into each file that we have in this repository:


File name: "SQL R nhanes 1999-2014 walking impairment"

This file downloads raw data files from 1999-2014 and merges them into a "master" file that is the first start to any research project. 
NHANES breaks down their data into years and within each year they further break down their datasets into questions that are similar to one another. This is useful once you 
can navigate the site and once you get a through understanding of their data dictionary. We join our different datasets using basic SQL commands. We lastly output our datafile as a CSV file so we can impute missing values.

File name: “Missing imputation mi package”
First thing to note is that if you want to do not wish to impute missing values then we can just omit any rows that 
have at least one missing value; the R command that is quite useful is “na.omit()”. If you wish to maximize your sample size 
then we go ahead and impute missing values into our dataset. The most common way of imputing missing values
would be to take the means of our distribution and replace all missing values with this value.  
The problem in our case is that most of the variables in our dataset are categorical. So we instead decide to use a R package
called “MI”. “The mi package provides functions for data manipulation, imputing missing values in an approximate Bayesian framework”
(taken from the CRANA MI R documentation).

File name: “descriptive statistics with graphics”
In this file we write code that does statistical inference in the form of: Chi- square test of equal proportions, 
Chi-square test of independence and we create a correlation matrix of all variables in our dataset. 
The graphics we provide are pie charts and box plots all using GGplot2.

Filename: ”Logistic regression JAPMA”
In this file we conduct binary logistic regression to try and forecast how walking impairment is affected by
all variables in our dataset. We come up with a statistically significant model as well as provide some model performance 
metrics Such as a ROC curve.
