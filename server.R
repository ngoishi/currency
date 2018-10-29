library(prophet)
require(RCurl)
library(rvest)
library(data.table)

function(input, output) {
  output$plot1 <- renderPlot({
    
    fileurl <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vSiFo4cr-L9HNgQAOJdbHTZmE16VnYjcJ3DZYneS13fQ0W4W-kfh2pV2WTnc7FtBILtVGuq9w1eOCxb/pub?gid=0&single=true&output=csv"
    fileCSV <- getURL(fileurl,.opts=list(ssl.verifypeer=FALSE))
    df <-  read.csv(textConnection(fileCSV),header=TRUE)
    
    df[,1]<-as.Date(df[,1], format = "%m/%d/%Y")
    colnames(df)<- c("ds", "y")
    m <- prophet(df)
    future <- make_future_dataframe(m, periods = input$forward*30)
    forecast <- predict(m, future)
    plot(m, forecast)
  })
}
