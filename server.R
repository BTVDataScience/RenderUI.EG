# This took some wrangling with reactive elements but it now works.
#
#

shinyServer(function(input, output) {
  
  #reactive data setting, allows for the data set to change via user interaction
  master.data <- reactive(get(input$dataset))
  
  #Below are my tests.  This is an overly simple example where I run my all my tests on the selected data.  Clearly there are many different ways to do this, but again here is a working example
  #really you want to insert S.A.D.A.(super awesome data analysis) here
  
    test.data.normal <- reactive({
    data.set.for.testing <- master.data()
    TEST.results <- shapiro.test(data.set.for.testing)[2]
    return(TEST.results$p.value)
  })
  
  test.data.uniform <- reactive({
    data.set.for.testing <- master.data()
    TEST.results <- ks.test(data.set.for.testing, "punif")[2]
    return(TEST.results$p.value)
  })
  
  #End of testing or S.A.D.A.
  
  #Here's it the renderUI bidness
      output$testOutput <- renderUI({
        
      #The code in here is probably the most kludgey set of code.
        
        #getting the p.values for my control language(the if then statements)
        TEST.normal <- test.data.normal()
        TEST.unif <- test.data.uniform()
        
        if(TEST.normal > .06){
          
          #code that looks and acts more like server.R code to get things, data, plotting etc. in order
          data.set <- master.data()    
          output$plottest1 <- renderPlot({
          plot(sample(data.set, input$obs), xlab = "Time or Something", ylab="Ichiban KPI", main = "Plot of Underlying Data")
          abline(h=mean(sample(data.set, input$obs)), col ="red")
          })
          output$Main.Title <- renderText(paste("This Data is normal, p.value = ", round(TEST.normal, 4)))
          
          #code that looks and acts like ui.R code to get stuff all purty
          fluidRow(
            column(1, ""),
            column(10, plotOutput("plottest1"), align="center"),
            column(1, "")
          )
        
        #end of ui if data passes the above test
        }
      
        else if (TEST.unif > .05){
          
          
          #code that looks and acts more like server.R code to get thing data etc. in order
          data.set <- master.data()    
          output$plottest2 <- renderPlot({
            plot(density(sample(data.set, input$obs)), col="blue", main="Plot of Density of Underlying Data")
          })
          output$Main.Title <- renderText(paste("This Data is uniform, p.value = ", round(TEST.unif, 4)))
          
          #code that looks and acts like ui.R code to get stuff all purty
          fluidRow(
            column(1, ""),
            column(10, plotOutput("plottest2"), align="center"),
            column(1, "")
          )
        
        #end of ui if data passes the above test
        }
        
        else if (TEST.normal < .05 && TEST.unif < .05) {
          
          #code that looks and acts more like server.R code to get thing data etc. in order
          data.set <- master.data()    
          output$plottest3 <- renderPlot({
            plot(ecdf(sample(data.set, input$obs)), main="Cumulative Density Plot of Underlying Data")
          })
          output$Main.Title <- renderText(paste("This Data is not normal, p.value = ", round(TEST.normal, 6)))
          
          #code that looks and acts like ui.R code to get stuff all purty
          fluidRow(
            column(6, includeHTML("picture.html"), align="center"),
            column(6,
                   fluidRow(
                      column(2, ""),
                      column(8, plotOutput("plottest3")),
                      column(2, "")
                   )
            )
          )
        
        #end of ui if data passes the above test
        }
        
    #end of the renderUI statement
    #end of kludgey code
    })
      
#end of server function
})
