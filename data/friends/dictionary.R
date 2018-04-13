library(plyr)
setwd('C:\\Users\\guptakas\\Rscripts\\dictionary')
afinn<-read.csv('afinn.txt',sep = '\t')
colnames(afinn)<-c("name","rating")
colnames(afinn)
#afinn$rating<-factor(afinn$rating)
str(afinn)
afinn<-data.frame(afinn)
afinn$rating<-laply(afinn$rating,function(text){
  if(text<=-4 && text>=-5){
    text<-'high stress'
  }
  else if(text <=-2 && text>=-3)
    text<-'partial stress'
  else if(text <=1 && text >=-1)
    text<-'normal'
  else if(text>=2 && text<=3)
    text<-'happy'
  else if(text>=4 && text <=5)
    text<-'very happy'
})
x<-split(afinn,afinn$rating)
happy<-x[1]
highstress<-x[2]
normal<-x[3]
partialstress<-x[4]
veryhappy<-x[5]
write.table(cbind(happy[2],happy[3]),'happy.csv',sep=",", row.names=FALSE, col.names=FALSE)
write.table(cbind(veryhappy[2],veryhappy[3]),'veryhappy.csv',sep=",", row.names=FALSE, col.names=FALSE)
write.table(cbind(normal[2],normal[3]),'normal.csv',sep=",", row.names=FALSE, col.names=FALSE)
write.table(cbind(partialstress[2],partialstress[3]),'partialstress.csv',sep=",", row.names=FALSE, col.names=FALSE)
write.table(cbind(highstress[2],highstress[3]),'highstress.csv',sep=",", row.names=FALSE, col.names=FALSE)
write.table(afinn,'afinn.csv',sep=",", row.names=FALSE, col.names=FALSE)