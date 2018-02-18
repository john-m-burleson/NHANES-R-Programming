#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))
# loading the Mi library into R
library(mi)
library(partykit)
#lets read into R our dataset
final_data<-read.csv(file.choose(),header = TRUE)
#coding our variables properly
#lets code all of our categorical variables as factors
#########################################################################
#turning walking imparment
final_data$PFQ061B<-as.ordered(final_data$PFQ061B);class(final_data$PFQ061B)
#diabetes
final_data$DIQ010<-factor(final_data$DIQ010);class(final_data$DIQ010)
#education
final_data$DMDEDUC2<-factor(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
#gender
final_data$RIAGENDR<-factor(final_data$RIAGENDR);class(final_data$RIAGENDR)
#asthma
final_data$MCQ010<-factor(final_data$MCQ010);class(final_data$MCQ010)
#arthritis
final_data$MCQ160A<-factor(final_data$MCQ160A);class(final_data$MCQ160A)
#high blood pressure
final_data$BPQ020<-factor(final_data$BPQ020);class(final_data$BPQ020)
#shortness of breath
final_data$CDQ010<-factor(final_data$CDQ010);class(final_data$CDQ010)
final_data<-as.data.frame(final_data)
#converting our dataset to a "missing data frame"
final_data_imputted<-missing_data.frame(final_data[2:13])
show(final_data_imputted)
#running our missing imputation model as well as providing diagnostics
imputations <- mi(final_data_imputted, n.iter = 30, n.chains = 4, max.minutes = 20)
plot(imputations)
#checking for convergance in our chains (checking that they are comparable to one another)
round(mipply(imputations, mean, to.matrix = TRUE), 3)
##
# our 4 chains show a gerally well modelded imputation model and
# they seem to be relativley similar to one another (which is what we want)

#############################################################################
#                          Fixing imputted values                           #
#############################################################################
#age coded according to NHANES{20 to 85}
final_data$RIDAGEYR[which(final_data$RIDAGEYR<=20)]=20
final_data$RIDAGEYR[which(final_data$RIDAGEYR>=85)]=85
fivenum(final_data$RIDAGEYR)
#BMI coded according to NHANES{11.49 to 66.44}
final_data$BMXBMI[which(final_data$BMXBMI<=12)]=12
final_data$BMXBMI[which(final_data$BMXBMI>=66)]=66
fivenum(final_data$BMXBMI)
#coding our walking imparment variable as 0/1
final_data$PFQ061B[which(final_data$PFQ061B<=1)]=0
final_data$PFQ061B[which(final_data$PFQ061B>=2)]=1
fivenum(final_data$PFQ061B)
hist(final_data$PFQ061B)
# using decision trees to find a homogenous split for BMI and Age
#######################BMI binning######################
athens<-ctree(final_data$PFQ061B ~ final_data$BMXBMI);plot(athens)
#our cut point is going to be 37 years of age according to our decision tree
final_data$binned_bmi<-cut(final_data$BMXBMI,c(11,33.8,86))
summary(final_data)
#######################Age binning######################
greece<-ctree(final_data$PFQ061B ~ final_data$RIDAGEYR);plot(greece)
#our cut point is going to be 44 years of age according to our decision tree
final_data$binned_age<-cut(final_data$RIDAGEYR,c(0,44,85))
summary(final_data)
#lets write out our dataset into a csv file
write.csv(final_data, "final_data_correct_binary_no_bin.csv", row.names=T)

