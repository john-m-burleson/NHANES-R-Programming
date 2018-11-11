#lets make sure there are no strangling datasets in our global enviroment
rm(list=ls(all=TRUE))
#loading necessary libraries that we are going to need for analysis
library(sqldf)
library(RNHANES)
#############################################################################
#      1999-2000 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
physical_9900<-nhanes_load_data("PFQ","1999-2000")
body_measure_9900<-nhanes_load_data("BMX","1999-2000")
demographics_9900<-nhanes_load_data("DEMO","1999-2000")
diabetes_9900<-nhanes_load_data("DIQ","1999-2000")
medical_conditions_9900<-nhanes_load_data("MCQ","1999-2000")
blood_pressure_9900<-nhanes_load_data("BPQ","1999-2000")
cardiovascular_9900<-nhanes_load_data("CDQ","1999-2000")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_99_sql<-sqldf('SELECT  SEQN, PFQ060B FROM physical_9900 where PFQ060B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_99_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_9900 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_99_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_9900 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_99_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_9900 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_99_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_9900 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_99_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_9900 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_99_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_9900 WHERE CDQ010<=2')
#We write code in SQL on how to inner join our 7 dataset {pleae refer to index of code[1.index]}
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 1999-2000
group_merge_99<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_99_sql,body_meassure_99_sql,diabetes_99_sql,demographics_99_sql,medical_conditions_99_sql,blood_pressure_99_sql,cardiovascular_99_sql))
#let us rename our dependant variable to match up with other years
names(group_merge_99)[2]<-"PFQ061B"
#############################################################################
#      2001-2002 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2001-2002
physical_0102<-nhanes_load_data("PFQ","2001-2002")
body_measure_0102<-nhanes_load_data("BMX","2001-2002")
demographics_0102<-nhanes_load_data("DEMO","2001-2002")
diabetes_0102<-nhanes_load_data("DIQ","2001-2002")
medical_conditions_0102<-nhanes_load_data("MCQ","2001-2002")
blood_pressure_0102<-nhanes_load_data("BPQ","2001-2002")
cardiovascular_0102<-nhanes_load_data("CDQ","2001-2002")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_01_sql<-sqldf('SELECT  SEQN, PFQ060B FROM physical_0102 where PFQ060B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_01_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_0102 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_01_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_0102 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_01_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_0102 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_01_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_0102 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_01_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_0102 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_01_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_0102 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2001-2002
group_merge_01<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_01_sql,body_meassure_01_sql,diabetes_01_sql,demographics_01_sql,medical_conditions_01_sql,blood_pressure_01_sql,cardiovascular_01_sql))
#let us rename our dependant variable to match up with other years
names(group_merge_01)[2]<-"PFQ061B"
#############################################################################
#      2003-2004 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2003-2004
physical_0304<-nhanes_load_data("PFQ","2003-2004")
body_measure_0304<-nhanes_load_data("BMX","2003-2004")
demographics_0304<-nhanes_load_data("DEMO","2003-2004")
diabetes_0304<-nhanes_load_data("DIQ","2003-2004")
medical_conditions_0304<-nhanes_load_data("MCQ","2003-2004")
blood_pressure_0304<-nhanes_load_data("BPQ","2003-2004")
cardiovascular_0304<-nhanes_load_data("CDQ","2003-2004")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_03_sql<-sqldf('SELECT  SEQN, PFQ061B FROM physical_0304 where PFQ061B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_03_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_0304 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_03_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_0304 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_03_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_0304 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_03_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_0304 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_03_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_0304 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_03_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_0304 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2003-2004
group_merge_03<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_03_sql,body_meassure_03_sql,diabetes_03_sql,demographics_03_sql,medical_conditions_03_sql,blood_pressure_03_sql,cardiovascular_03_sql))
#############################################################################
#      2005-2006 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2005-2006
physical_0506<-nhanes_load_data("PFQ","2005-2006")
body_measure_0506<-nhanes_load_data("BMX","2005-2006")
demographics_0506<-nhanes_load_data("DEMO","2005-2006")
diabetes_0506<-nhanes_load_data("DIQ","2005-2006")
medical_conditions_0506<-nhanes_load_data("MCQ","2005-2006")
blood_pressure_0506<-nhanes_load_data("BPQ","2005-2006")
cardiovascular_0506<-nhanes_load_data("CDQ","2005-2006")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_05_sql<-sqldf('SELECT  SEQN, PFQ061B FROM physical_0506 where PFQ061B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_05_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_0506 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_05_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_0506 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_05_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_0506 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_05_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_0506 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_05_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_0506 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_05_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_0506 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2005-2006
group_merge_05<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_05_sql,body_meassure_05_sql,diabetes_05_sql,demographics_05_sql,medical_conditions_05_sql,blood_pressure_05_sql,cardiovascular_05_sql))
#############################################################################
#      2007-2008 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2007-2008
physical_0708<-nhanes_load_data("PFQ","2007-2008")
body_measure_0708<-nhanes_load_data("BMX","2007-2008")
demographics_0708<-nhanes_load_data("DEMO","2007-2008")
diabetes_0708<-nhanes_load_data("DIQ","2007-2008")
medical_conditions_0708<-nhanes_load_data("MCQ","2007-2008")
blood_pressure_0708<-nhanes_load_data("BPQ","2007-2008")
cardiovascular_0708<-nhanes_load_data("CDQ","2007-2008")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_07_sql<-sqldf('SELECT  SEQN, PFQ061B FROM physical_0708 where PFQ061B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_07_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_0708 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_07_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_0708 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_07_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_0708 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_07_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_0708 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_07_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_0708 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_07_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_0708 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2007-2008
group_merge_07<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_07_sql,body_meassure_07_sql,diabetes_07_sql,demographics_07_sql,medical_conditions_07_sql,blood_pressure_07_sql,cardiovascular_07_sql))
#############################################################################
#      2009-2010 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2009-2010
physical_0910<-nhanes_load_data("PFQ","2009-2010")
body_measure_0910<-nhanes_load_data("BMX","2009-2010")
demographics_0910<-nhanes_load_data("DEMO","2009-2010")
diabetes_0910<-nhanes_load_data("DIQ","2009-2010")
medical_conditions_0910<-nhanes_load_data("MCQ","2009-2010")
blood_pressure_0910<-nhanes_load_data("BPQ","2009-2010")
cardiovascular_0910<-nhanes_load_data("CDQ","2009-2010")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_09_sql<-sqldf('SELECT  SEQN, PFQ061B FROM physical_0910 where PFQ061B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_09_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_0910 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_09_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_0910 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_09_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_0910 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_09_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_0910 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_09_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_0910 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_09_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_0910 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2009-2010
group_merge_09<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_09_sql,body_meassure_09_sql,diabetes_09_sql,demographics_09_sql,medical_conditions_09_sql,blood_pressure_09_sql,cardiovascular_09_sql))
#############################################################################
#      2011-2012 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2011-2012
physical_1112<-nhanes_load_data("PFQ","2011-2012")
body_measure_1112<-nhanes_load_data("BMX","2011-2012")
demographics_1112<-nhanes_load_data("DEMO","2011-2012")
diabetes_1112<-nhanes_load_data("DIQ","2011-2012")
medical_conditions_1112<-nhanes_load_data("MCQ","2011-2012")
blood_pressure_1112<-nhanes_load_data("BPQ","2011-2012")
cardiovascular_1112<-nhanes_load_data("CDQ","2011-2012")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_11_sql<-sqldf('SELECT  SEQN, PFQ061B FROM physical_1112 where PFQ061B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_11_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_1112 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_11_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_1112 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_11_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_1112 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_11_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_1112 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_11_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_1112 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_11_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_1112 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2011-2012
group_merge_11<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_11_sql,body_meassure_11_sql,diabetes_11_sql,demographics_11_sql,medical_conditions_11_sql,blood_pressure_11_sql,cardiovascular_11_sql))
#############################################################################
#      2013-2014 Data Manipulation{Using SQL and basic R functions}         #
#############################################################################
#loading our datasets for 2013-2014
physical_1314<-nhanes_load_data("PFQ","2013-2014")
body_measure_1314<-nhanes_load_data("BMX","2013-2014")
demographics_1314<-nhanes_load_data("DEMO","2013-2014")
diabetes_1314<-nhanes_load_data("DIQ","2013-2014")
medical_conditions_1314<-nhanes_load_data("MCQ","2013-2014")
blood_pressure_1314<-nhanes_load_data("BPQ","2013-2014")
cardiovascular_1314<-nhanes_load_data("CDQ","2013-2014")
#######let us pull all of our desired  variables our of datasets########
#getting all of our variables that we want from the physical dataset
physical_13_sql<-sqldf('SELECT  SEQN, PFQ061B FROM physical_1314 where PFQ061B <= 4')
#getting all of our variables that we want from BMX dataset
body_meassure_13_sql<-sqldf('SELECT  SEQN, BMXBMI FROM body_measure_1314 where BMXBMI <= 67')
#getting all of our variables that we want from DIQ dataset
diabetes_13_sql<-sqldf('SELECT  SEQN, DIQ010 FROM diabetes_1314 where DIQ010 <= 2')
#getting all of our variables that we want from DEMO dataset
demographics_13_sql<-sqldf('SELECT  SEQN, DMDEDUC2 ,RIAGENDR , RIDAGEYR FROM demographics_1314 where DMDEDUC2<=5 AND RIAGENDR<=2 AND RIDAGEYR<=84')
#getting all of our medical conditions from our MCQ dataset
medical_conditions_13_sql<-sqldf('SELECT SEQN,MCQ010, MCQ160A,MCQ220 FROM medical_conditions_1314 WHERE MCQ010<=2 AND MCQ160A<=2 AND MCQ220<=2')
#getting high blood pressure variable from BPQ dataset
blood_pressure_13_sql<-sqldf('SELECT SEQN,BPQ020 FROM blood_pressure_1314 WHERE BPQ020<=2')
#getting shortness of breath varible from CDQ dataset
cardiovascular_13_sql<-sqldf('SELECT SEQN,CDQ010 FROM cardiovascular_1314 WHERE CDQ010<=2')
#lets merge these 7 smaller datasets into 1 bigger dataset for the year 2013-2014
group_merge_13<-Reduce(function(x, y) merge(x, y, all=TRUE, by="SEQN"), list(physical_13_sql,body_meassure_13_sql,diabetes_13_sql,demographics_13_sql,medical_conditions_13_sql,blood_pressure_13_sql,cardiovascular_13_sql))

# lets merge all of our datasets(1999-2014) to make our final dataset
final_data <- rbind(group_merge_99,group_merge_01,group_merge_03, group_merge_05,group_merge_07, group_merge_09,group_merge_11,group_merge_13)
# let us make sure that there are no duplicated values in our dataset
table(duplicated(final_data$SEQN))
# Since all of our values in our table evaluate to false we know there are no
# duplicated values
write.csv(final_data, "final_data_missing.csv", row.names=T)

