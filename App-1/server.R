library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    
    counts <- tapply(myData$Percent, list(as.factor(myData$Party), as.factor(myData$Kommun)), mean)
    names <- colnames(counts)
    counts <- t(as.matrix(counts[rownames(counts)=="SD"]))
    colnames(counts) <- names
    barplot(counts, main="Votes, by municipal and party",
            xlab="Municipal", col=c("lightblue"),
            legend = "SD")
    
    if (input$select==1) {   
      
    counts <- tapply(myData$Percent, list(as.factor(myData$Party), as.factor(myData$Kommun)), mean)
    barplot(counts, main="Votes, by municipal and party",
            xlab="Municipal", col=c("darkblue", "green", "blue", "orange", "red" ,"darkred", "seagreen", "lightblue", "pink"),
            legend = myData$Party[1:9] , beside=TRUE)
    } else if (input$select==2) {
        
      counts <- tapply(myData$Percent, list(as.factor(myData$Party), as.factor(myData$Kommun)), mean)
      names <- colnames(counts)
      counts <- t(as.matrix(counts[rownames(counts)=="SD"]))
      colnames(counts) <- names
      barplot(counts, main="Votes, by municipal and party",
              xlab="Municipal", col=c("lightblue"),
              legend = "SD")
    }
    
  })
})