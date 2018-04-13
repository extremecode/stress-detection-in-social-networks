setwd('C:\\Users\\guptakas\\Rscripts')
#install.packages("TwitteR")
library(stringr)
library(twitteR)
library(xlsx)
library(plyr)
library(dplyr)
api_key<- "gRFwcBHf7DPbo2X56EYaiMTgQ"
api_secret <- "oWQ1cu6oJxCfFRJKvlrGctgLlMPo5b2HhzqnCDBdzNNiz7kBeZ"
access_token <- "347291173-Ch9M1Jb7TC3DJdpBWE1mrpiyMqOQEsekQBNHp2vu"
access_token_secret <- "hjUKjUhGgeVdhL2QWRgusGJJ3VFjoY5Y1ydlLX5nGlVbk"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
#tweets creation
tweets<-searchTwitter('narendramodi',n=50)
tweets.df<-twListToDF(tweets)
dim(tweets.df)
colnames(tweets.df)
tweets.df$created
#user information retrival
temp_df <- twListToDF(lookupUsers('narendramodi'))
temp_df
colnames(temp_df)
a<-temp_df[rep(seq_len(nrow(temp_df)), each=100),]
dim(a)
#social factors
User <- getUser("narendramodi")
location(User)
User_Friends_IDs<-User$getFriends(n=2)
#lucaspuente_follower_IDs<-lucaspuente$getFollowers(n=1000)
#lucaspuente_follower_IDs
#length(lucaspuente_follower_IDs)
length(User_Friends_IDs)
friends.df<-twListToDF(User_Friends_IDs)
for (x in friends.df$name) { 
print(x)
}
#print(x)
#print(class(x))
#searchTwitter(x,n=1)
#rough work
tweets<-searchTwitter(tweetuser,n=5)
tweetuser<-'Exam Warriors'
#tweets<-userTimeline(tweetuser,n=3000)
tweets.df<-twListToDF(tweets)
clean_tweet = laply(tweets.df$text, function(tweet) {
  tweet = gsub('https://','',tweet) # removes https://
  tweet = gsub('http://','',tweet) # removes http://
  tweet=gsub('[^[:graph:]]', ' ',tweet) ## removes graphic characters
  #like emoticons
  tweet = gsub('[[:punct:]]', '', tweet) # removes punctuation
  tweet = gsub('[[:cntrl:]]', '', tweet) # removes control characters
  tweet = gsub('\\d+', '', tweet) # removes numbers
  tweet=str_replace_all(tweet,"[^[:graph:]]", " ")
  
  tweet = tolower(tweet) # makes all letters lowercase
})
tweets.df$text<-clean_tweet
temp_df <- twListToDF(lookupUsers(tweetuser))
temp_df
colnames(temp_df)
a<-temp_df[rep(seq_len(nrow(temp_df)), each=length(tweets)),]
a
b<-cbind(a,tweets.df$created,tweets.df$text)
names(b)[1]<-paste("user name")
names(b)[18]<-paste("tweets date")
names(b)[19]<-paste("tweet ") 
dim(b)
colnames(b)
filename<-tweetuser
Format<-"csv"
File<-paste(filename,Format,sep=".")
write.csv(b, file = File)

#happyfuntweets  sadquotes

tweetuser<-'hello'
temp_df <- data.frame(tweetuser)
temp_df
colnames(temp_df)
a<-temp_df[rep(seq_len(nrow(temp_df)), each=5),]
a
