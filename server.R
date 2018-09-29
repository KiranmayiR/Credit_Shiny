

# Define server logic required to draw the plots
shinyServer(function(input, output, session) {
  

  # Create a bar plot to see the effect of Variables on Approval in tab 3 of Shiny App
  output$speaker_plot <- renderPlot({
    e4<- ggplot(data = CA, aes(x = factor(Approved)))
    e4+ geom_bar(aes_string(fill = input$inputvar), position = input$PosType)+xlab('Approved') 
    # k <- ggplot(data = CA, aes(x = input$inputvar )) 
    # k + geom_bar(aes(fill = factor(Approved)), position = input$PosType)
  })

  # customize the length drop-down menu; display 10 rows per page by default
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(CA, options = list(lengthMenu = c(5, 10, 15), 
                                     pageLength = 10,class = 'white-space: nowrap'))
  })
  
  
  # Figures 1- 5 are the histograms displayed in tab 1 of the Shiny App
  output$figure1 <- renderPlot({
    g <- ggplot(data = CA, aes(x = Debt))
    g + geom_histogram(binwidth = .5) +ggtitle('Frequency Distribution of Debt') + ylab('Frequency')
  })
  
  output$figure2 <- renderPlot({
    g1 <- ggplot(data = CA, aes(x = CreditScore))
    g1 + geom_histogram(binwidth = 8) +ggtitle('Frequency Distribution of Credit Score') + ylab('Frequency')
  })
  
  output$figure3 <- renderPlot({
    zoom <- coord_cartesian(xlim = c(0, 30000))
    g2 <- ggplot(data = CA, aes(x = Income))
    g2 + geom_histogram(binwidth = 500) +zoom +ggtitle('Frequency Distribution of Income') + ylab('Frequency')
    
  })
  
  output$figure4 <- renderPlot({
    g3 <- ggplot(data = CA, aes(x = YearsEmployed))
    g3 + geom_histogram(binwidth = 5)+ggtitle('Frequency Distribution of Years Employed') + ylab('Frequency')
    
  })
  
  output$figure5 <- renderPlot({
    CA$Age <- as.numeric(CA$Age)
    g4 <- ggplot(data = CA, aes(x = Age))
    g4 + geom_histogram(binwidth = 5)+ggtitle('Frequency Distribution of Age') + ylab('Frequency')
    
  })
  
  
  # Figures 6 -10 are the histograms displayed in tab 2 of the Shiny App
  output$figure6 <- renderPlot({
    CA$Debt_log <- log(CA$Debt)
    g <- ggplot(data = CA, aes(x = Debt_log))
    g + geom_histogram(binwidth = .5) +ggtitle('Frequency Distribution of Log of Debt') + ylab('Frequency')+xlab('Log of Debt')
    
  })
  
  output$figure7 <- renderPlot({
    CA$CreditScore_log <- log(CA$CreditScore)
    g1 <- ggplot(data = CA, aes(x = CreditScore_log))
    g1 + geom_histogram(binwidth = .5) +ggtitle('Frequency Distribution of Log of Credit Score') + ylab('Frequency') +xlab('Log of Credit Score')
    
  })
  
  output$figure8 <- renderPlot({
    CA$Income_log <- log(CA$Income)
    g2 <- ggplot(data = CA, aes(x = Income_log))
    g2 + geom_histogram(binwidth = .5) +ggtitle('Frequency Distribution of Log of Income') + ylab('Frequency') + xlab('Log of Income')
    
  })
  
  output$figure9 <- renderPlot({
    CA$YearsEmployed_log <- log(CA$YearsEmployed)
    g3 <- ggplot(data = CA, aes(x = YearsEmployed_log))
    g3 + geom_histogram(binwidth = .5) +ggtitle('Frequency Distribution of Log of Years Employed') + ylab('Frequency') +xlab('Log of Years Employed')
    
  })
  
  output$figure10 <- renderPlot({
    CA$Age <- as.numeric(CA$Age)
    CA$Age_log <- log(CA$Age)
    g4 <- ggplot(data = CA, aes(x = Age_log))
    g4 + geom_histogram(binwidth = .5) +ggtitle('Frequency Distribution of Log of Age') + ylab('Frequency') + xlab('Log of Age')
    
  })
  
  output$figure11 <- renderPlot({
    g <- ggplot(data = CA, aes(x = reorder(EducationLevel,Income,median), y = Income))
    g + geom_boxplot()+ coord_cartesian(ylim = c(0,2000)) + xlab('Education Level')
   })
 
  # Violin plots
  output$figure12 <- renderPlot({
    p <- ggplot(data = CA, aes(x = Ethnicity, y = Debt)) 
    p + geom_violin(aes(fill = Ethnicity))
  })
  
  output$figure13 <- renderPlot({
  g <- ggplot(data = CA, aes(x = YearsEmployed, y = Income))
  g + geom_point(aes(color = EducationLevel))
  })
  
  # Pairwise Coorelation of the fields
  output$corr_plot <- renderPlot({
    scatterplotMatrix(CA[ ,c(3,8,11,15)],
                      diagonal='histogram',
                      ellipse=TRUE)
    
  })
  
 })