
#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))
#lets read into R our dataset
orginal<-read.csv(file.choose(),header = TRUE)
final_data<-subset(orginal,select=-c(MCQ160A,BPQ020))
#recoding our variables for analysis
final_data$PFQ061B[which(final_data$PFQ061B<=1)]=0
final_data$PFQ061B[which(final_data$PFQ061B>=2)]=1
hist(final_data$PFQ061B)
#cancer
final_data$MCQ220[which(final_data$MCQ220==1)]=0
final_data$MCQ220[which(final_data$MCQ220==2)]=1
hist(final_data$MCQ220)
#asthma
final_data$MCQ010[which(final_data$MCQ010==1)]=0
final_data$MCQ010[which(final_data$MCQ010==2)]=1
hist(final_data$MCQ010)
#gender
final_data$RIAGENDR[which(final_data$RIAGENDR==1)]=0
final_data$RIAGENDR[which(final_data$RIAGENDR==2)]=1
hist(final_data$RIAGENDR)
#diabetes
final_data$DIQ010[which(final_data$DIQ010==1)]=0
final_data$DIQ010[which(final_data$DIQ010==2)]=1
hist(final_data$DIQ010)
summary(final_data)
#lets make our variables correct classes
final_data$PFQ061B<-as.ordered(final_data$PFQ061B);class(final_data$PFQ061B)
final_data$MCQ220<-as.factor(final_data$MCQ220);class(final_data$MCQ220)
final_data$MCQ010<-as.factor(final_data$MCQ010);class(final_data$MCQ010)
final_data$DMDEDUC2<-as.factor(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
final_data$RIAGENDR<-as.factor(final_data$RIAGENDR);class(final_data$RIAGENDR)
final_data$DIQ010<-as.factor(final_data$DIQ010);class(final_data$DIQ010)
str(final_data)
#we are going to use our basic glm function to model our walking imparment variable
#### note that high blood pressure is not signifigant in our model so we drop it
model<-glm(final_data$PFQ061B~.,final_data,family = "binomial")
#since our data is not balenceed we want to use precision recall as opposed to AUC to evaluate our model
summary(model)
####testing to see the signifigance of our logistic regression model 
###### calculating goodness of fit statistic
#### we are going to compare our model against a model with just the intercept term 
#calculating the difference between our current model and our null model
with(model, null.deviance - deviance)
#calculating degrees of freedom for our model
with(model, df.null - df.residual)
#calculating P-value for this test
with(model, pchisq(null.deviance - deviance, df.null - df.residual, lower.tail = FALSE))
#log liklihood value Since this value is very extreme we say that this model is highly signigigant
logLik(model)
## odds ratios and 95% CI
round(exp(cbind(OR = coef(model), confint(model))),digits = 3)
#lets plot a ROC curve and get the AUC of our model
prob<-predict(model)
final_data$prob=prob
#ROc curve
library(pROC)
library(ggplot2)
g<-roc(PFQ061B~prob,data = final_data);g
plot.roc(PFQ061B~prob,data = final_data, legacy.axes=TRUE, col='red', grid=c(0.125, 0.125), mar=c(4,4,2,2), main='ROC Curve' )
#percision and recall curve
library(ROCR)
pred <- prediction(final_data$prob, final_data$PFQ061B)
perf1 <- performance(pred, "prec", "rec")
plot(perf1,col=rainbow(15),main="Percision and recall graphic")














