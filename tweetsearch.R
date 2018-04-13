searchtweet=function(x,y){
  a = searchTwitter(x,y)
  sum = laply(a,function(t)t$getText())
  return(sum)
}
