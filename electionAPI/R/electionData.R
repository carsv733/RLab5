

# Exempel:
# myData <- electionData(c("0136", "0140"), "/Users/Martini/Downloads/slutresultat")

electionData <- function(kommun, path) {
  library(XML)
  library(httr)
  #För möjliga argument "kommun" och "path" (path=sökväg)
  list <- list.files(path,full.names=T,pattern = "*R.xml")
  folder <- "/slutresultat_"
  format <- "R.xml"
  
  file<-c()
  for (i in seq(length(kommun))) {
    file[i] <- as.character(paste(path, folder, kommun[i], format, sep=""))
  }
  
  #Nu går detta köra med en 
  
  listTest<-character()
  for (i in seq(length(list))) {
    if (list[i]%in%file) {
      listTest <- append(listTest, list[i])
    }
  }
  
  datafr <- data.frame()
  for(i in seq(length(file))) {
    dataTest <- xmlTreeParse(listTest[i])
    r <- xmlRoot(dataTest)
    k <- xmlToList(dataTest)
    dataTest <- k$KOMMUN$GILTIGA
    temps <- r[["KOMMUN"]]
    namn <- xmlAttrs(temps)[["NAMN"]]
    temps <- temps[names(temps) == "GILTIGA"]
    df <- data.frame(matrix(unlist(temps), ncol=7, byrow=T),stringsAsFactors=FALSE)
    df$X1 <- NULL
    colnames(df) <- c("Party", "Votes","Votes_PrevEl","Percent","Percent_PrevEl","Percent_Change")
    df["Kommun"] <- NA
    df$Kommun <- namn
    datafr <- rbind(datafr,df)
  }
  
  datafr$Percent <- sub(",",".",datafr$Percent)
  datafr$Percent  <- as.numeric(datafr$Percent)
  datafr$Percent_PrevEl <- sub(",",".",datafr$Percent_PrevEl)
  datafr$Percent_PrevEl  <- as.numeric(datafr$Percent_PrevEl)
  datafr$Percent_Change <- sub(",",".",datafr$Percent_Change)
  datafr$Percent_Change  <- as.numeric(datafr$Percent_Change)
  datafr$Votes  <- as.numeric(datafr$Votes)
  datafr$Votes_PrevEl  <- as.numeric(datafr$Votes_PrevEl)
  
  return(datafr)
}


