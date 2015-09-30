
library(shiny)

counts <- tapply(myData$Percent, list(as.factor(myData$Party), as.factor(myData$Kommun)), mean)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  
  output$plot <- renderPlot({
    
    
    if (10 %in% input$select) {   
      
    barplot(counts, main="Votes, by municipal and party",
            xlab="Municipal", col=c("darkblue", "green", "blue", "orange", "red" ,"darkred", "seagreen", "lightblue", "pink"),
            legend = myData$Party[1:9] , beside=TRUE)
    
    } else {
            
       for (i in 1:9) {
         #verkar inte finnas i inputselect!
        if (i%in%input$select==FALSE) {
          counts[-i,]
        }
      }
      barplot(counts, main="Votes, by municipal and party",
              xlab="Municipal", col=c("lightblue"),
              legend = myData$Party[1:9] , beside=TRUE)
    }
    
  })
})