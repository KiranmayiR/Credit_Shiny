library(shiny)
library(shinythemes)
library(shinydashboard)
library(DT)
library(car)
library(ggplot2)



###########################################
#########  Create the Shiny App ###########
###########################################

shinyUI(fluidPage(
      # Application title
    titlePanel("Credit Approval Analysis"),
    #sidebarUserPanel("Kiranmayi Nimmala", "nimmala.kiranmayi@gmail.com"),
    #h3(titlePanel("Kiranmayi Nimmala, nimmala.kiranmayi@gmail.com")),
    HTML(paste("Created and maintained by Kiranmayi Nimmala (nimmala.kiranmayi@gmail.com);"),
         paste("Data last updated",Sys.time())),
    
    sidebarLayout(fluid = TRUE,
                  
                  # Sidebar with a slider and selection inputs
                  sidebarPanel(
                    
                    # Tab 1 Text
                    conditionalPanel(
                      'input.dataset === "Distribution"',
                      strong("Background:"),
                      fluidRow("The credit Approval dataset has been obtained from the Machine Learning Repository of 
                                University of California, Irvine(UCI)"),
                      br(),
                      
                      fluidRow("The aim of the analysis is to look for impact the various fields have on our
                                final outcome of Credit Approval."),
                      br(),
                      
                     
                      strong("Observations from figures on the right:"),
                      fluidRow("(1) Comparision of 5 continuous variables. Age, Debt, Credit Score, Income and Years Employed"),
                      fluidRow("(2) The Frequency Distribution of these fields show us that the data is not well distributed
                                   about the mean and its mostly skewed to the right."),
                      fluidRow("(3) And looking at the Box plots, Violin plots and the Scatter plots below, we can see we have 
                               a scaling problem here. This could be due to the presence of Outliers in our data."),
                      fluidRow("(4) These plots were shown to also understand the correlation among the independant variables.")
                      ),
                    
                    # Tab 2 Text
                    conditionalPanel(
                      'input.dataset === "Log Transformation"',
                      
                      fluidRow("Log transformations have been applied to these variables to reduce the skew and present better scaled plots
                                as shown here."),
                      br(),
                      br(),
                      
                      fluidRow("Some preliminary insights:"),
                      fluidRow("(1) The age of the population mostly ranges from 30-40."),
                      fluidRow("(2) The frequency distribution of the Debt ranges from 0-3 "),
                      fluidRow("(3) The Credit Score mainly concentrated from 0-3"),
                      fluidRow("(4) Income  mainly concentrated from 4-8"),
                      fluidRow("(5) Years Employed is between -1 to 2")
                      ),      
      
                    
                    # Tab 3 plots
                    conditionalPanel(
                      'input.dataset === "Effect on Approval"',
                      # selectInput("selection_var", "Choose from the list of the Variables and thier effect on Approval:",
                      # 
                      #  choices = c("EducationLevel", "Ethnicity", "PriorDefault", "Employed")),
                      #  actionButton("update", "Change"),
                      hr(),
                      
                      fluidRow(column(12, selectizeInput('inputvar',
                                                        'Choose from the list of the Variables',
                                                        choices = c("EducationLevel", "Ethnicity", "PriorDefault", "Employed"),
                                                        width = 1000)),
                               column(6, radioButtons('PosType',
                                                      'Graph Positions',
                                                      choices = c('fill', 'dodge'),
                                                      width = 100)))
                      
                      
                      # sliderInput("freq",
                      #             "Bin Width:",
                      #             min = 1,  max = 3000, value = 1)
                    ),

                
                    # Tab 4 pairwise correlation
                    
                    conditionalPanel(
                      'input.dataset === "Pairwise Correlation"',
                      fluidRow("From the below pairwise comparisions in the scatterplot, we see that the variables
                               Years Employed, Credit score and Income all have a linear correlaton with
                               with the class attribute Approved"),
                      br(),
                      fluidRow("The relationship between Approved and the other variables is not immediately apparent from the plot.")
                      
                    
                      )
                    ),
                  
                  # Main Panel
                  mainPanel(
                    tabsetPanel(
                      id = 'dataset',
                      tabPanel("Distribution", 
                               fluidRow(
                               ),
                               plotOutput("figure1"),plotOutput("figure2"),plotOutput("figure3"),plotOutput("figure4"),plotOutput("figure5"),
                               plotOutput("figure11"),
                               plotOutput("figure12"),plotOutput("figure13")
                      ),
                      tabPanel("Log Transformation", 
                               fluidRow(
                               ),
                               plotOutput("figure6"),
                               br(),
                               plotOutput("figure7"),plotOutput("figure8"),plotOutput("figure9"),plotOutput("figure10")
                      ),
                      tabPanel("Effect on Approval", 
                               p("Plot the  effect of different variables on the final outcome."),
                               plotOutput("speaker_plot"),
                               DT::dataTableOutput("mytable1")),
                      
                      tabPanel("Pairwise Correlation",
                               br(),
                               br(),
                               plotOutput("corr_plot"))
                      
                      )
                  )
                  
                  )))

               