#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))

#lets read into R our dataset
final_data<-read.table(file.choose(),header = TRUE)
#lets load all libraries
library(neuralnet)

#lets do some final data manipulation on BMXBMI and RIDAgeyearn
#lets first start with our age variable lets start our by making our values ranging from 18-84
final_data$RIDAGEYR[which(final_data$RIDAGEYR<= 20)] = 20
final_data$RIDAGEYR[which(final_data$RIDAGEYR>= 84)] = 84
summary(final_data$RIDAGEYR);hist(final_data$RIDAGEYR)
#now lets bin our BMXBMI variable so that we are looking at something appropriate
final_data$BMXBMI[which(final_data$BMXBMI<= 13)] = 13
#walking imparment 0/1
final_data$PFQ061B[which(final_data$PFQ061B>=2 )] = 2
summary(final_data$PFQ061B)


#looks all good lets proceed to modeling our data
summary(final_data)
#lets make our variables correct classes
#one thing to note about this algorithim is that since our response is ordinal we have a problem of the linearity of this variable. So we are going to violate this assumption and assume that all of our categories are equally spaced.
final_data$PFQ061B<-as.factor(final_data$PFQ061B);class(final_data$PFQ061B)
final_data$CDQ010<-as.factor(final_data$CDQ010);class(final_data$CDQ010)
final_data$BPQ020<-as.factor(final_data$BPQ020);class(final_data$BPQ020)
final_data$MCQ220<-as.factor(final_data$MCQ220);class(final_data$MCQ220)
final_data$MCQ160A<-as.factor(final_data$MCQ160A);class(final_data$MCQ160A)
final_data$MCQ010<-as.factor(final_data$MCQ010);class(final_data$MCQ010)
final_data$DMDEDUC2<-as.integer(final_data$DMDEDUC2);class(final_data$DMDEDUC2)
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

#lets fit a k nearest neighbors model to our dataset
#lets normalize our numerical variables, using a min/max normilization
normalize<-function(x){
  
  return((x - min(x))/(max(x) - min(x)))
}
#normalize our countinous variables
test$normalize_ridageyr<-normalize(test$RIDAGEYR)
test$normalize_bmxbmi<-normalize(test$BMXBMI)
train$normalize_ridageyr<-normalize(train$RIDAGEYR)
train$normalize_bmxbmi<-normalize(train$BMXBMI)
#lets set up our formular for our working model
the_matrix<-model.matrix(~PFQ061B+CDQ010+BPQ020+MCQ160A+MCQ010+normalize_bmxbmi+DMDEDUC2+
                           RIAGENDR+normalize_ridageyr+DIQ010+MCQ220,data = train)
the_test_matrix<-model.matrix(~PFQ061B+CDQ010+BPQ020+MCQ160A+MCQ010+normalize_bmxbmi+DMDEDUC2+
                                RIAGENDR+normalize_ridageyr+DIQ010+MCQ220,data = test)
#lets fit a Neural network and our error measurement that we are going to be using is cross entropy
summary(the_matrix)    
set.seed(6475)
n<-neuralnet(PFQ061B2~CDQ0102+BPQ0202+MCQ160A2+MCQ0102+normalize_bmxbmi+DMDEDUC2+
               RIAGENDR2+normalize_ridageyr+DIQ0102+MCQ2202, data = the_matrix,
             hidden =3,linear.output = FALSE,err.fct = "ce",)
#lets plot our neural network, we will need to go back and pick an optimal number of hidden nodes
plot(n)
output<-compute(n,the_matrix[ ,3:12])
hold<-output$net.result
#we will say that if someone has a proability of 50% of more for having walking imparment given our 
#model we will say that they have walking imparment
hold_out<-ifelse(hold>.5,1,0)
tab1<-table(hold_out,train$PFQ061B);tab1
#calculating misclassification error=0.2550067821
1-sum(diag(tab1))/sum(tab1)
#lets do the same thing for test data to see if we get a consistent missclassification error

output<-compute(n,the_test_matrix[ ,3:12])
hold_test<-output$net.result
hist(hold_test)
#we will say that if someone has a proability of 50% of more for having walking imparment given our 
#model we will say that they have walking imparment
hold_out<-ifelse(hold_test>.5,1,0)
tab1<-table(hold_out,test$PFQ061B);tab1
#calculating misclassification error=0.2652409831 
1-sum(diag(tab1))/sum(tab1)
#we say that although the model is not perfect and can use some tuning 
#our resutls are not drastically different

