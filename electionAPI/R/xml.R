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

