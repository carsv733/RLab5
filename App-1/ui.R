library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello World!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    
    sidebarPanel(
      
      checkboxGroupInput("select", label = h3("Select parties"), 
                  choices = list("Alla partier" = 1, "M" = 2, "C" = 3,
                                 "FP" = 4, "KD" = 5, "S" = 6, "V" = 7,
                                 "MP" = 8, "SD" = 9, "FI" = 10), selected = 1)),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")   
    )
  )
))