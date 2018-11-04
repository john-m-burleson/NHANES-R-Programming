#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))

#lets read into R our dataset
final_data<-read.table(file.choose(),header = TRUE)
#lets load all libraries
library(partykit)


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
final_data$DMDEDUC2<-as.ordered(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
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


#lets fit a model to this data
set.seed(6475)
tree<-ctree(train$PFQ061B~.,data=train,control = ctree_control(mincriterion = .99))
plot(tree)
#lets check out the predictablity of this tree according to this model
tab<-table(predict(tree),train$PFQ061B)
print(tab)
#missclassification error
1-sum(diag(tab))/sum(tab)