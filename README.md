## create a twitter App
http://docs.inboundnow.com/guide/create-twitter-application/
## setup a twitter authentication 
```markdown
twitterauth<-function(){
  #install.packages("TwitteR")
  require('twitteR')
  api_key<- "put api key here"
  api_secret <- "put api sceret key here"
  access_token <- "put access token here"
  access_token_secret <- "pu access secret here"
  setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
}
```
**save the Oauth token**
**passing yes as argument**
```markdown
> setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
[1] "Using direct authentication"
Use a local file ('.httr-oauth'), to cache OAuth access credentials between R sessions?

1: Yes
2: No

Selection:yes
```
## pull a user data
**search the user timeline and save the data as a data frame**
```markdown
tweets<-userTimeline(tweetuser,n=nooftweets)
  tweets.df<-twListToDF(tweets)
```
**clean the tweets**
```markdown
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
```
**get user profile information**
```markdown
tweets.df$text<-clean_tweet
  temp_df <- twListToDF(lookupUsers(tweetuser))
  temp_df
```
**replicate the information on the basis on no of tweets and bind the information in  a new table**
```markdown
a<-temp_df[rep(seq_len(nrow(temp_df)), each=length(tweets)),]
b<-cbind(a,tweets.df$created,tweets.df$text)
```
**rename the columns and save these as a username.csv file**
```markdown
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
```
**create a wrap function for user data retrival on the basis of no of tweets**
```markdown
Userdataret<-function(tweetuser,nooftweets){
  setwd('C:\\Users\\guptakas\\Rscripts\\data\\user')
  require('dplyr')
  require('twitteR')
  require('stringr')
  #tweets<-searchTwitter(tweetuser,n=nooftweets)
  tweets<-userTimeline(tweetuser,n=nooftweets)
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
}
```
## Retrive user friends 
```markdown
  User <- getUser("paas the user name here")
  User_Friends_IDs<-User$getFriends(n=nooffriends)##pass no of friends u want to retrieve
  length(User_Friends_IDs)##check if retrieve correctly or not
  friends.df<-twListToDF(User_Friends_IDs)
  for (x in friends.df$name) { ##loop over each  friends and collect their information
  Frnddataret(x,no_of_tweets)
  }
```
## Stemming
Corpus comes with built-in support for the algorithmic stemmers provided by the Snowball Stemming Library, which supports the following languages: arabic (ar), danish (da), german (de), english (en), spanish (es), finnish (fi), french (fr), hungarian (hu), italian (it), dutch (nl), norwegian (no), portuguese (pt), romanian (ro), russian (ru), swedish (sv), tamil (ta), and turkish (tr). You can select one of these stemmers using either the full name of the language of the two-letter country code
```markdown
text <- "love loving lovingly loved lover lovely love"
text_tokens(text, stemmer = "en") # english stemmer
[[1]]
[1] "love"  "love"  "love"  "love"  "lover" "love"  "love" 
```
[editor on GitHub](https://github.com/akash5551/stress-detection-in-social-networks/edit/master/README.md) 
### Dictionary Stemmer
_One common way to build a stemmer is from a list of (term, stem) pairs. Many such lists are available at lexoconista.com_
**download the dictonary**
```markdown
url <- "http://www.lexiconista.com/Datasets/lemmatization-en.zip"
  tmp <- tempfile()
  download.file(url, tmp)
```
**extract the dictionary in a frame**
```markdown
con <- unz(tmp, "lemmatization-en.txt", encoding = "UTF-8")
  tab <- read.delim(con, header=FALSE, stringsAsFactors = FALSE)
  names(tab) <- c("stem", "term")
  head(tab)
```

**define the stemming function**
```markdown
stem_list <- function(term) {
    i <- match(term, tab$term)
    if (is.na(i)) {
      stem <- term
    } else {
      stem <- tab$stem[[i]]
    }
    stem
  }
```
**apply on a dataset** 
_laply take each line of text and perform operations on that build under plyr package_
```markdown
 dataset$tweet.<-laply(dataset$tweet.,function(text){
    x<-text_tokens(text, stemmer = stem_list) # english stemmer
    text<-paste(unlist(x), collapse = ' ')  
  })
```
#### create a stem function for a dataset
```markdown
stemop<-function(dataset){
  require('plyr')
  require('corpus')
  #text stemming for live data
  url <- "http://www.lexiconista.com/Datasets/lemmatization-en.zip"
  tmp <- tempfile()
  download.file(url, tmp)
  # extract the contents
  con <- unz(tmp, "lemmatization-en.txt", encoding = "UTF-8")
  tab <- read.delim(con, header=FALSE, stringsAsFactors = FALSE)
  names(tab) <- c("stem", "term")
  head(tab)
  tab
  stem_list <- function(term) {
    i <- match(term, tab$term)
    if (is.na(i)) {
      stem <- term
    } else {
      stem <- tab$stem[[i]]
    }
    stem
  }
  dataset$tweet.<-laply(dataset$tweet.,function(text){
    x<-text_tokens(text, stemmer = stem_list) # english stemmer
    text<-paste(unlist(x), collapse = ' ')  
  })
  return(dataset)
}
```
**apply the stemming function on a dataset**
```markdown
nm<-read.csv('narendramodi.csv')
stemdataset<-stemop(nm)
nm$tweet.[264]
stemdataset$tweet.[264]
```
**output**
```markdown
> nm$tweet.[264]
[1] it is gladdening to witness a very healthy spirit of competition among the states to draw maximum investment this  tcoqejbqfzcla
264 Levels:                                                                                         ...
> stemdataset$tweet.[264]
[1] "it be gladden to witness a very healthy spirit of competition among the state to draw maximum investment this tcoqejbqfzcla"
```
_ gladdening is converted to root gladden_

#### dataset source
[dataset link](https://docs.google.com/file/d/0B04GJPshIjmPRnZManQwWEdTZjg/edit)
#### train the model using doc2vec
_This uses system facilities to convert a character vector between encodings: the ‘i’ stands for ‘internationalization’_
```markdown
### loading and preprocessing a training set of tweets
# function for converting some symbols
conv_fun <- function(x) iconv(x, "latin1", "ASCII", "")
```
#### load the training set
_load the tweets and assign columnnames_
```markdown
tweets_classified <- read.csv('training.1600000.processed.noemoticon.csv',stringsAsFactors=FALSE)
dim(tweets_classified)
colnames(tweets_classified)<- c('sentiment', 'id', 'date', 'query', 'user', 'text')
head(tweets_classified$text)
```
#### some tweets and their classes
```markdown
> head(tweets_classified$text)
[1] "is upset that he can't update his Facebook by texting it... and might cry as a result  School today also. Blah!"
[2] "@Kenichan I dived many times for the ball. Managed to save 50%  The rest go out of bounds"                      
[3] "my whole body feels itchy and like its on fire "                                                                
[4] "@nationwideclass no, it's not behaving at all. i'm mad. why am i here? because I can't see you all over there. "
[5] "@Kwesidei not the whole crew "
> head(tweets_classified$sentiment)
[1] 0 0 0 0 0
```
#### apply a conversion
_convert the sentiment classes to 0&1 and tweets character from latint to ascii_
```markdown
tweets_classified%>%
  # converting some symbols
  dmap_at('text', conv_fun) %>%
  # replacing class values
  mutate(sentiment = ifelse(sentiment == 0, 0, 1))
```
#### split into train and test
80% to train and 20% test
```markdown
# data splitting on train and test
set.seed(2340)
trainIndex <- createDataPartition(tweets_classified$sentiment, p = 0.8, 
                                  list = FALSE, 
                                  times = 1)
tweets_train <- tweets_classified[trainIndex, ]
tweets_test <- tweets_classified[-trainIndex, ]
```
####
```markdown
```

####
```markdown
```

####
```markdown
```
For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).


### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/akash5551/stress-detection-in-social-networks/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
