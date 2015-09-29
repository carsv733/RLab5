
install.packages("XML")
install.packages("httr")
library(XML)
library(httr)
install.packages("jsonlite")
library(jsonlite)


myData <- electionData(c("0136", "0140"), "D:/Dokument/732A50/")

electionData <- function(kommun, path) {

#För möjliga argument "kommun" och "path" (path=sökväg)
list <- list.files(paste(path, "slutresultat/", sep=""),full.names=T,pattern = "*R.xml")

folder <- "slutresultat/slutresultat_"
format <- "R.xml"

file<-c()
for (i in seq(length(kommun))) {
  file[i] <- as.character(paste(path, folder, kommun[i], format, sep=""))
}

#Nu går detta köra med en 

listTest<-c()
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
  colnames(df) <- c("Parti", "Röster","Röster_FGVal","Procent","Procent_FGVal","Procent_Ändring")
  df["Kommun"] <- NA
  df$Kommun <- namn
  datafr <- rbind(datafr,df)
}
return(datafr)
}

