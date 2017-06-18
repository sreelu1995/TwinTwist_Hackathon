library(gWidgets)
library(httr)
require(twitteR)
options(guiToolkit="tcltk")
consKey <- "ysBNXIqaIUKlp4EHuPYt4bx4j"
consSecret<-"zSXeB8V6sP7OiNOG65ikyCSGu7gXYSZZ1aN2fO3YwCe9BGuqdX"
token<-"2709245677-rAHmN80p0h3LBqF0WfGkv4gzcPto8Rt36ZTyjHd"
tokenSecret<-"vL1sMaDKwdowD7Wp6YF9W0KSfp1jKEEDcz26fZ5kPEpQS"
myapp = oauth_app("twitter", key=consKey, secret=consSecret)

# sign using token and token secret
sig = sign_oauth1.0(myapp, token=token, token_secret=tokenSecret)
my_timeline=GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
library(jsonlite)
json1 = content(my_timeline)
json2 = jsonlite::fromJSON(toJSON(json1))

# #retweet 
# retweets=GET("https://api.twitter.com/1.1/statuses/retweets_of_me.json", sig)
# json_rtw = content(retweets)
# json_rtw2 = jsonlite::fromJSON(toJSON(json_rtw))
# json_rtw2[1:5,4]

#search topics

shiny_tweets=GET("https://api.twitter.com/1.1/search/tweets.json?q=Marathons", sig)
json_shiny = content(shiny_tweets)
json_shiny2 = jsonlite::fromJSON(toJSON(json_shiny))
statuses<-json_shiny2$statuses
statuses[1:15,1:4]
write.csv(json_shiny2,"./data.txt")

