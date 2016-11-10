##  Quick STM for testing

load(paste0(getwd(),"/clean_data/moldova_clean.RData"))

set.seed(67)
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

test_model <- stm(docs, vocab, 5, data = meta, init.type = "Spectral", max.em.its = 700)

topic_words <- labelTopics(test_model, n = 10)
topic_names <- topic_words$frex[,1:5]
topic_names <- apply(topic_names,1, function(topic_names) paste(topic_names, collapse = ", "))

cloud(test_model, topic = match(topic_names[3], topic_names), type=c("model", "documents"))

stm_model <- test_model
save("stm_model", file = "test_stm.RData")
