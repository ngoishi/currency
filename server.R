library(prophet)
require(RCurl)
library(rvest)
library(data.table)

function(input, output) {
  output$plot1 <- renderPlot({
    
fileurl <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vSiFo4cr-L9HNgQAOJdbHTZmE16VnYjcJ3DZYneS13fQ0W4W-kfh2pV2WTnc7FtBILtVGuq9w1eOCxb/pub?gid=51203032&single=true&output=csv"
fileCSV <- getURL(fileurl,.opts=list(ssl.verifypeer=FALSE))
df <-  read.csv(textConnection(fileCSV),header=TRUE)
mydf <- data.frame(df[,2])
mydf <- copy(mydf)
setDT(mydf, keep.rownames = TRUE)
colnames(mydf)<- c("ds", "y")
m <- prophet(df)
future <- make_future_dataframe(m, periods = 120)
forecast <- predict(m, future)
plot(m, forecast)
  })
}
