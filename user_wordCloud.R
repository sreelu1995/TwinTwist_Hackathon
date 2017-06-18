require("ggplot2")
require("grid")
require("plyr")
library(reshape)
library(ScottKnott)

library(lda)
library(tm)
library(SnowballC)


fetched_user<-user.table[(user.table$interest %in% user_name), ]
Interets<-fetched_user$interest
dataValues<-Marathon$text
#dataValues=dataValues[sample(nrow(dataValues),size=1000,replace=FALSE),]


#dim(dataValues)
## Text Pre-processing.
## Creating a Corpus from the Orginal Function
## interprets each element of the vector x as a document
CorpusObj<- VectorSource(dataValues);
CorpusObj<-Corpus(CorpusObj);
CorpusObj <- tm_map(CorpusObj, tolower) # convert all text to lower case
CorpusObj <- tm_map(CorpusObj, removePunctuation) 
CorpusObj <- tm_map(CorpusObj, removeNumbers)
#CorpusObj <- tm_map(CorpusObj, removeWords, stopwords("english")) 
CorpusObj <- tm_map(CorpusObj, stemDocument, language = "english") ## Stemming the words 
CorpusObj<-tm_map(CorpusObj,stripWhitespace)
##create a term document matrix 
CorpusObj.tdm <- TermDocumentMatrix(CorpusObj, control = list(minWordLength = 3))
inspect(CorpusObj.tdm[1:10,1:10])
findFreqTerms(CorpusObj.tdm, lowfreq=1003)
dim(CorpusObj.tdm)
CorpusObj.tdm.sp <- removeSparseTerms(CorpusObj.tdm, sparse=0.88)
dim(CorpusObj.tdm.sp)
## Show Remining words per 15 Document.
inspect(CorpusObj.tdm.sp[1:10,1:10])







## visualizing  the TD --  

## Words Cloud Visualizing
library(wordcloud)
library(RColorBrewer)

par(bg = "black")
mTDM <- as.matrix(CorpusObj.tdm)
v <- sort(rowSums(mTDM),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
pal <- brewer.pal(8, "Dark2")
pal <- pal[-(1:2)]
png("./pics/wordcloud.png", width=1280,height=800)
wordcloud(d$word,d$freq, scale=c(8,.3),min.freq=2,max.words=100, random.order=T, rot.per=.15, colors=pal, vfont=c("sans serif","plain"),bg="black")
dev.off()