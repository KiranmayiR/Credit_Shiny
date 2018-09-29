library(shiny)
library(shinythemes)
library(shinydashboard)
library(DT)
library(car)
library(ggplot2)

Credit_Approval <- read.csv("Credit_Approval.csv")

str(Credit_Approval)
CA <- Credit_Approval

CA[CA == '?'] <- NA


# Do this to figure the missing value %
pMiss <- function(x){sum(is.na(x))/length(x)*100}
apply(CA,2,pMiss)
library(VIM)
aggr_plot <- aggr(CA, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE)


# Step1: Convert Character values to numeric/factor

CA$Gender <- ifelse(CA$Gender == 'b', 0, 1) 
CA$Married <- ifelse(CA$Married == 'u', 0, 1)
CA$PriorDefault <- as.factor(ifelse(CA$PriorDefault == 'f', 0, 1))
CA$Employed <- as.factor(ifelse(CA$Employed == 'f', 0, 1))
CA$DriversLicense <- ifelse(CA$DriversLicense == 'f', 0, 1)
CA$Approved <- ifelse(CA$Approved == '-', 0, 1)

# Step2 : Impute Missing Values

# Categorical fields
ss <-table(CA$EducationLevel)
CA$EducationLevel[is.na(CA$EducationLevel)] <- names(ss[which.max(ss)])

tt <-table(CA$Ethnicity)
CA$Ethnicity[is.na(CA$Ethnicity)] <- names(tt[which.max(tt)])

#Numeric fields
CA$Gender[is.na(CA$Gender)] <- round(median(CA$Gender, na.rm = TRUE))
CA$Married[is.na(CA$Married)] <- round(median(CA$Married, na.rm = TRUE))
CA$Age <- as.numeric(CA$Age)
CA$Age[is.na(CA$Age)] <- round(median(CA$Age, na.rm = TRUE))



#rsconnect::deployApp('C:/Users/Kiran/Documents/NYCDS/Projects/CreditApp_Shiny')