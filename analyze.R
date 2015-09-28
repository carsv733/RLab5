
install.packages("XML")
install.packages("httr")
library(XML)
library(httr)
install.packages("jsonlite")
library(jsonlite)

val_get<-function() {
  temp <- "http://api.kolada.se/v1/data/permunicipality/N00092/0580"
  to30 <- fromJSON(txt=temp)
  temp <- "http://api.kolada.se/v1/data/permunicipality/N00093/0580"
  to49 <- fromJSON(txt=temp)
  temp <- "http://api.kolada.se/v1/data/permunicipality/N00094/0580"
  up49 <- fromJSON(txt=temp)
  total<-merge(to30$values[,3:4],to49$values[,3:4],by="period")
  total<-merge(total,up49$values[,3:4],by="period")
  total
}

test<-val_get()
