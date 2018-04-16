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
For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/akash5551/stress-detection-in-social-networks/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
