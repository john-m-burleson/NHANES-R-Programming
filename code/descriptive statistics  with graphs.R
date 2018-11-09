
#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))
#lets read into R our dataset
orginal<-read.csv(file.choose(),header = TRUE)
final_data<-subset(orginal,select=-c(MCQ160A,BPQ020))
final_data$PFQ061B[which(final_data$PFQ061B<=1)]=0
final_data$PFQ061B[which(final_data$PFQ061B>=2)]=1
hist(final_data$PFQ061B)
#loading required libraries
library(ggplot2)
#making sure our variables are of the right class
final_data$PFQ061B<-as.ordered(final_data$PFQ061B);class(final_data$PFQ061B)
final_data$MCQ160A<-as.numeric(final_data$MCQ160A);class(final_data$MCQ160A)
final_data$MCQ010<-as.numeric(final_data$MCQ010);class(final_data$MCQ010)
final_data$DMDEDUC2<-as.ordered(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
final_data$RIAGENDR<-as.numeric(final_data$RIAGENDR);class(final_data$RIAGENDR)
final_data$DIQ010<-as.numeric(final_data$DIQ010);class(final_data$DIQ010)
str(final_data)
#############################################################################
#                            Inferential statistics                         #
#############################################################################
# using the R package called "mi" we imputted our missing values and we go from 
# an effective sample size of 12,000 to 78,000. We are going to assume that our 
# missing imputation model is a good fit to our data and this means that we should
# get comparable when comapring our imputted dataset and our orginal dataset. 
#############################################################################
#                      chi-square test of independence                      #
#############################################################################
#walking impairment vs. Gender
chisq.test(final_data$PFQ061B,final_data$RIAGENDR)
#############################################################################
#            Chi-square equal proportins(comparing mutiple proportions)     #
#############################################################################
# walking impairment
table(final_data$PFQ061B)
chisq.test(c(56120,22210), p = c(1/2,1/2))
#diabetes
table(final_data$DIQ010)
chisq.test(c(5214,73116), p = c(1/2,1/2))
#education
table(final_data$DMDEDUC2)
chisq.test(c(10766,13242,17934,20978,15410), p = c(1/5 ,1/5 ,1/5 ,1/5 ,1/5 ))
#gender
table(final_data$RIAGENDR)
chisq.test(c(38001,40329), p = c(1/2,1/2))
#asthma
table(final_data$MCQ010)
chisq.test(c(9760,68570), p = c(1/2,1/2))
#arthritis
table(final_data$MCQ160A)
chisq.test(c(19229,59101), p = c(1/2,1/2))
#cancer
table(final_data$MCQ220)
chisq.test(c(7789,70541), p = c(1/2,1/2))
#high blood pressure
table(final_data$BPQ020)
chisq.test(c(16348,61982), p = c(1/2,1/2))
#Age
summary(final_data$binned_age)
chisq.test(c(32282,46048), p = c(1/2,1/2))
#bmi
summary(final_data$binned_bmi)
chisq.test(c(73220,5110), p = c(1/2,1/2))
#############################################################################
#                    Correlation matrix plot using GGplot2                  #
#############################################################################
#turning walking impairment
final_data$PFQ061B<-as.numeric(final_data$PFQ061B);class(final_data$PFQ061B)
#diabetes
final_data$DIQ010<-as.numeric(final_data$DIQ010);class(final_data$DIQ010)
#education
final_data$DMDEDUC2<-as.numeric(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
#gender
final_data$RIAGENDR<-as.numeric(final_data$RIAGENDR);class(final_data$RIAGENDR)
#asthma
final_data$MCQ010<-as.numeric(final_data$MCQ010);class(final_data$MCQ010)
#age
final_data$RIDAGEYR<-as.numeric(final_data$RIDAGEYR);class(final_data$RIDAGEYR)
#cancer
final_data$MCQ220<-as.numeric(final_data$MCQ220);class(final_data$MCQ220)
#bmi
final_data$BMXBMI<-as.numeric(final_data$BMXBMI);class(final_data$final_data$BMXBMI)
#making our data set a data frame
final_data<-as.data.frame(final_data);str(final_data)
#we are going to plot a correlation matrix since a scatter plot matrix will not 
# Changing labels of the walking impairment variable becasue it makese the boxplots look better
names(final_data)[1]<-"Walking Impairment"
final_data$`Walking Impairment`[which(final_data$`Walking Impairment`==0)]<- "No walking imparment"
final_data$`Walking Impairment`[which(final_data$`Walking Impairment`==1)]<- "Walking imparment"
table(final_data$`Walking Impairment`)
names(final_data)[2]<-"Cancer"
names(final_data)[3]<-"Asthma"
names(final_data)[4]<-"Age"
names(final_data)[5]<-"Education"
names(final_data)[6]<-"Gender"
names(final_data)[7]<-"BMI"
names(final_data)[8]<-"Diabetes"
str(final_data)
library(corrplot)
#matrix or correlation coefficents
m<-cor(final_data)
#actual plot
corrplot(m, method = "shade",col.main="red",type = "upper",tl.cex = .9,order = "AOE")


#############################################################################
#                               Descriptive Statistics                      #
#############################################################################
#making box plots for each dependant countinous variable
#Age
library(ggplot2)
qplot(x =final_data$`Walking Impairment`, y = final_data$Age,data=final_data, geom=c("boxplot"), 
      fill=`Walking Impairment`, main="Boxplot of Age",xlab = "Walking impairment",ylab = "Age")

#BMI
qplot(x = final_data$`Walking Impairment`, y = final_data$BMI,data=final_data, geom=c("boxplot"), 
      fill=`Walking Impairment`, main="Boxplot of BMI",xlab = "Walking impairment",ylab = "BMI")

#pie charts 
#walking imparment
table(final_data$PFQ061B)
df_walk <- data.frame(
  group = c("No walking impairment", "Walking impairment"),
  value = c(56120, 22210)
)
# piechart
ggplot(df_walk, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for Walking Impairment")+
  geom_text(label = percent(df_walk))
#arthritis
table(final_data$MCQ160A)
df_arthritis <- data.frame(
  group = c("1", "2"),
  value = c(19229, 59101)
)
# piechart
ggplot(df_blood, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for arthritis")
#asthma
table(final_data$MCQ010)
df_asthma <- data.frame(
  group = c("Has asthma", "No asthma"),
  value = c(9760, 68570)
)
# piechart
ggplot(df_asthma, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for Asthma")
#gender
table(final_data$RIAGENDR)
df_gender <- data.frame(
  group = c("Male", "Female"),
  value = c(38001, 40329)
)
# piechart
ggplot(df_gender, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for Gender")
#education
table(final_data$DMDEDUC2)
df_education <- data.frame(
  group = c("No high school", "Some high school","graduated high school","some college","college graduate"),
  value = c(107660, 13242,20978,20978,15410)
)
# piechart
ggplot(df_education, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for education")
#diabetes
table(final_data$DIQ010)
df_diabetes<- data.frame(
  group = c("Has Diabetes", "No Diabetes"),
  value = c(5214,73116)
)
# piechart
ggplot(df_diabetes, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for Diabetes")
#Cancer
library(ggplot2)
table(final_data$MCQ220)
df_cancer <- data.frame(
  group = c("Has cancer", "No cancer"),
  value = c(7789, 70541)
)
# piechart
ggplot(df_cancer, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for Cancer")
#hihg blood pressure
library(ggplot2)
table(final_data$BPQ020)
df_blood_pressure <- data.frame(
  group = c("1", "2"),
  value = c(16348, 61982)
)
# piechart
ggplot(df_blood_pressure, aes(x="", y=value, fill=group))+geom_bar(width = 1, stat = "identity")+ coord_polar("y", start=0)+ggtitle("Pie chart for hihg blood pressure")


#waffle charts
#walking imparment
library(scales)
library(waffle)
table(final_data$`Walking Impairment`)
vals <- c(72, 28)
val_names <- sprintf("%s (%s)", c("No Walking impairment", "Walking impairment"), percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle(vals,size = 1,title = "Distribution of Walking Impairment")
#Asthma
library(scales)
library(waffle)
table(final_data$Asthma)
vals <- c(12, 88)
val_names <- sprintf("%s (%s)", c("No Asthma", "Has Asthma"), percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle(vals,size = 1,title = "Distribution of Asthma")
#cancer
library(scales)
library(waffle)
table(final_data$Cancer)
vals <- c(10, 90)
val_names <- sprintf("%s (%s)", c("No Cancer", "Has Cancer"), percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle(vals,size = 1,title = "Distribution of Cancer")
#diabetes
library(scales)
library(waffle)
table(final_data$Diabetes)
vals <- c(7, 93)
val_names <- sprintf("%s (%s)", c("No Diabetes", "Has Diabetes"), percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle(vals,size = 1,title = "Distribution of Diabetes")
#education
library(scales)
library(waffle)
table(final_data$Education)
vals <- c(14, 17,23,27,19)
val_names <- sprintf("%s (%s)", c("No high school", "Some high school","Graduated high school","Some college","College graduate"), percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle(vals,size = 1,title = "Distribution of Education")
#gender
table(final_data$Gender)
vals <- c(49,51)
val_names <- sprintf("%s (%s)", c("Male","Female"), percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle(vals,size = 1,title = "Distribution of Gender")
