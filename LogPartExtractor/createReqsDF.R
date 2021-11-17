createReqsDF <- function(text, FileName, resource) {
  # source("createEmptyDF.R")
  source("extractReqStarts.R")
  source("extractReqFinishes.R")
  source("makeReqStartAndReqFinishEven.R")
  
  # reqDF <- createEmptyDF()
  
  reqStarts <- extractReqStarts(text)
  reqFinishes <- extractReqFinishes(text)
  
  reqList <- makeReqStartAndReqFinishEven(reqStarts, reqFinishes)
  
  reqDF <- data.frame(ReqStart = reqList$reqStarts, 
                      ReqFinish = reqList$reqFinishes)
  
  reqDF <- reqDF %>% 
    mutate(ReqStartMine = ReqStart,
           ReqFinishMine = ReqFinish)
  
  if(is.na(reqDF[1,]$ReqStartMine)) {
    reqDF[1,]$ReqStartMine <- 1
  }
  if(is.na(reqDF[nrow(reqDF),]$ReqFinishMine)) {
    reqDF[nrow(reqDF),]$ReqFinishMine <- length(text)
  }
  
  reqDF <- reqDF %>% 
    fill(ReqStart, ReqStartMine) %>% 
    group_by(ReqStart, ReqStartMine) %>% 
    summarise(ReqFinish = max(ReqFinish),
              ReqFinishMine = max(ReqFinishMine)) %>% 
    mutate("ResourceLine" = as.character(NA),
           "Resource" = resource,
           "RequestType" = as.character(NA), 
           "UserNameLine" = as.character(NA), 
           "UserName" = as.character(NA),
           "FileName" = FileName)
  
  return(reqDF)
}