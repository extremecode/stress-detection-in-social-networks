setwd('C:\\Users\\guptakas\\Rscripts\\data\\user')
stemop<-function(dataset){
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
nm<-read.csv('narendramodi.csv')
stemdataset<-stemop(nm)
nm$tweet.[264]
stemdataset$tweet.[264]
