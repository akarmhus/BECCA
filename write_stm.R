dataset <- list.files(paste0(getwd(), "/data/"))

for (d in 1:length(dataset)) {
  
  load(paste0(getwd(), "/data/", dataset[d], "/data.RData"))
  temp<-textProcessor(documents=clean$texts_eng,metadata=clean)
  meta<-temp$meta
  vocab<-temp$vocab
  docs<-temp$documents
  out <- prepDocuments(docs, vocab, meta)
  docs<- out$documents
  vocab<-out$vocab
  meta <-out$meta
  
  meta$EntryDate <- as.numeric(meta$EntryDate, format="%m/%d/%Y")
  meta$DQ2.Gender <- as.factor(meta$DQ2.Gender)
  meta$DQ3.Education <- as.factor(meta$DQ3.Education)
  meta$DQ1.Age <- as.factor(meta$DQ1.Age)
  
  stm <- stm(docs, vocab, 12, prevalence  =~ DQ1.Age + EntryDate + DQ3.Education + DQ2.Gender + Q7.Score,  data = meta) 
  
  save(stm, file=paste0(getwd(), "/data/", dataset[d], "/stm.RData"))
  }