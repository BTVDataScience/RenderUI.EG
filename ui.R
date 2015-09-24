
#This is a super simple ui.R taken almost entirely from the default ui.R when you start a new shiny app in Rstudio
#

shinyUI(fluidPage(
  
  # Application title
  titlePanel(textOutput("Main.Title")),
  
  #Sidebar with a slider input for number of bins and selector for dataset selection
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Dataset?", choices=c("Dataset 1"="dataset11", "Dataset 2"="dataset21", "Dataset 3"="dataset31"), selected = "Dataset 1"),
      sliderInput("obs",
                  "Number of Sampled Observations:",
                  min = 10,
                  max = 1000,
                  value = 10)
      
    ),
    
    # Here's the magic.  All the ui goodness is now in server.R within a reactive element
    mainPanel(
      uiOutput("testOutput")
    )
  )
))
