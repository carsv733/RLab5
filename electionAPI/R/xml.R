library(httr)
library(XML)

  list <- list.files("/Users/Martini/Downloads/slutresultat/",full.names=T,pattern = "*R.xml")

  datafr <- data.frame()
for(i in 2:4) {
  data <- xmlTreeParse(list[i])
  r <- xmlRoot(data)
  k <- xmlToList(data)
  data <- k$KOMMUN$GILTIGA
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

datafr$Procent <- sub(",",".",datafr$Procent)
datafr$Procent  <- as.numeric(datafr$Procent)
datafr$Procent_FGVal <- sub(",",".",datafr$Procent_FGVal)
datafr$Procent_FGVal  <- as.numeric(datafr$Procent_FGVal)
datafr$Procent_Ändring <- sub(",",".",datafr$Procent_Ändring)
datafr$Procent_Ändring  <- as.numeric(datafr$Procent_Ändring)
datafr$Röster  <- as.numeric(datafr$Röster)
datafr$Röster_FGVal  <- as.numeric(datafr$Röster_FGVal)

datafr
