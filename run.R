library(prophet)
library(rvest)
require(RCurl)

fileurl <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vSiFo4cr-L9HNgQAOJdbHTZmE16VnYjcJ3DZYneS13fQ0W4W-kfh2pV2WTnc7FtBILtVGuq9w1eOCxb/pub?gid=51203032&single=true&output=csv"
fileCSV <- getURL(fileurl,.opts=list(ssl.verifypeer=FALSE))
df <-  read.csv(textConnection(fileCSV),header=TRUE)
m <- prophet(df)
future <- make_future_dataframe(m, periods = 120)
forecast <- predict(m, future)
plot(m, forecast)+theme_bw()
