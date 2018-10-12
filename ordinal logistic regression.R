#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))

#lets read into R our dataset
final_data<-read.table(file.choose(),header = TRUE)
#lets do some final data manipulation on BMXBMI and RIDAgeyearn
#lets first start with our age variable lets start our by making our values ranging from 18-84
final_data$RIDAGEYR[which(final_data$RIDAGEYR<= 20)] = 20
final_data$RIDAGEYR[which(final_data$RIDAGEYR>= 84)] = 84
summary(final_data$RIDAGEYR);hist(final_data$RIDAGEYR)
#now lets bin our BMXBMI variable so that we are looking at something appropriate
final_data$BMXBMI[which(final_data$BMXBMI<= 13)] = 13
#looks all good lets proceed to modeling our data
summary(final_data)
#lets make our variables correct classes
final_data$PFQ061B<-as.ordered(final_data$PFQ061B);class(final_data$PFQ061B)
final_data$CDQ010<-as.factor(final_data$CDQ010);class(final_data$CDQ010)
final_data$BPQ020<-as.factor(final_data$BPQ020);class(final_data$BPQ020)
final_data$MCQ220<-as.factor(final_data$MCQ220);class(final_data$MCQ220)
final_data$MCQ160A<-as.factor(final_data$MCQ160A);class(final_data$MCQ160A)
final_data$MCQ010<-as.factor(final_data$MCQ010);class(final_data$MCQ010)
final_data$DMDEDUC2<-as.factor(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
final_data$RIAGENDR<-as.factor(final_data$RIAGENDR);class(final_data$RIAGENDR)
final_data$DIQ010<-as.factor(final_data$DIQ010);class(final_data$DIQ010)
str(final_data)
#lets start out first by making a test/train dataset
#how we are going to set up the test/ train datasets simply in a couple of lines. 
#we want to set a seed so that our results are reproducable.
set.seed(6475)
Partion_function<-sample(2,nrow(final_data),replace= TRUE,prob=c(.8,.2))
#setting a 80% weight of the observations on the training dataset
train<-final_data[Partion_function==1,]
#setting a 20% weight of our observations on our testing traninning dataset
test<-final_data[Partion_function==2, ]
#fitting regression model
#variables that we droppped from analysis: MCQ220
#as far as our link function goes since the distrubtion of our walking imparment variable is right skewed 
# we are going to use a negative log log link function to meet our assumptions as well as better
#match our data
library(MASS)
ordinal<-polr(train$PFQ061B~train$CDQ010+train$BPQ020+train$MCQ160A+train$MCQ010+train$RIDAGEYR+train$DMDEDUC2+train$RIAGENDR+train$BMXBMI+train$DIQ010,train,Hess = TRUE,method =c("loglog"))

#calculting p-vlaues
(ctable<-coef(summary(ordinal)))
p<-pnorm(abs(ctable[,"t value"]),lower.tail = FALSE)*2
(ctable<-cbind(ctable,"p value"=p))
#lets create some 95% confidence intervals for our variables in our model and lets try to visualize our confidence intervals
wald_ci<-confint(ordinal)
#lets round to 3 decimal places
round(wald_ci,digits = 3)
#####################################################################
#                     Confusion matrrix                             #
#####################################################################
#predictions accroding to our ordinal logistic regression model
pred<-predict(ordinal,train)
print(pred,digits=3)
#calcaulating confusion matrix for our training dataset
(tab<-table(pred,train$PFQ061B))
#calculating classification error
1-sum(diag(tab))/sum(tab)
#calculating the confusion matrix for our traning dataset
#make sure to rerun the model on the test dataset
pred1<-predict(ordinal,test)
(tab1<-table(pred1,test$PFQ061B))
#calculating classification error
1-sum(diag(tab1))/sum(tab1)

#####################################################################
#         assumption check to make sure our algorithim is ok        #
#####################################################################
#lets check the assumption of our model
#checking multicolinearity by seeing if our categoirgal variables are related to one another
library(corrplot)
#lets make all of our variables numeric so that we can check corrlation

final_data$PFQ061B<-as.numeric(final_data$PFQ061B);class(final_data$PFQ061B)
final_data$CDQ010<-as.numeric(final_data$CDQ010);class(final_data$CDQ010)
final_data$BPQ020<-as.numeric(final_data$BPQ020);class(final_data$BPQ020)
final_data$MCQ220<-as.numeric(final_data$MCQ220);class(final_data$MCQ220)
final_data$MCQ160A<-as.numeric(final_data$MCQ160A);class(final_data$MCQ160A)
final_data$MCQ010<-as.numeric(final_data$MCQ010);class(final_data$MCQ010)
final_data$DMDEDUC2<-as.numeric(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
final_data$RIAGENDR<-as.numeric(final_data$RIAGENDR);class(final_data$RIAGENDR)
final_data$DIQ010<-as.numeric(final_data$DIQ010);class(final_data$DIQ010)
str(final_data)
#plotting our correlation plot using the corplot
M <- cor(final_data)
corrplot(M, method= "shade")
  



