library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello World!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    
    sidebarPanel(
      
      checkboxGroupInput("select", label = h3("Select parties"), 
                  choices = list("C" = 1, "FI" = 2, "FP" = 3,
                                 "KD" = 4, "M" = 5, "MP" = 6, "S" = 7,
                                 "SD" = 8, "V" = 9, "Alla partier" = 10), selected = 10),
    actionButton("action", label = "Plot")),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")   
    )
  )
))