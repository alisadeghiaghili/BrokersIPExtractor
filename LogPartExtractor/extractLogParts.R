extractLogParts <- function(logsPath, resource){
  source("extractFileNames.R")
  source("createResultsEmptyList.R")
  source("importLog.R")
  source("createReqsDF.R")
  source("extractResourceLines.R")
  source("concatResourceLines.R")
  source("extractResourceTypes.R")
  
    fileNames <- extractFileNames(logsPath)
    resultList <- createResultsEmptyList()
    
    for (listInd in 1:length(fileNames)) {
      text <- importLog(logsPath = logsPath, fileName = fileNames[listInd])
      
      reqDF <- createReqsDF(text = text, FileName = fileNames[listInd], resource = resource)
      
      for (dfRow in 1:nrow(reqDF)) {
        ResourceLines <- extractResourceLines(text = text, dataDF = reqDF, row = dfRow, resource = resource)
        if(length(ResourceLines) > 0) {
          reqDF[dfRow, ]$ResourceLine <- concatResourceLines(ResourceLines = ResourceLines)
          reqDF[dfRow, ]$RequestType <- extractResourceTypes(text = text, ResourceLines = ResourceLines)
          
          UserNameLine <- grep(x = text[reqDF[dfRow, ]$ReqStartMine:reqDF[dfRow, ]$ReqFinishMine], pattern = '\\[\\"name\\"\\,\\"[a-zA-Z.]*\\"\\]') + reqDF[dfRow, ]$ReqStartMine - 1
          reqDF[dfRow, ]$UserNameLine <- UserNameLine %>% as.character() %>% str_c(collapse = ", ")
          reqDF[dfRow, ]$UserName <- str_extract_all(string = text[reqDF[dfRow, ]$ReqStartMine:reqDF[dfRow, ]$ReqFinishMine], pattern = '\\[\\"name\\"\\,\\"[a-zA-Z.]*\\"\\]', simplify = TRUE) %>% 
            as.vector() %>% 
            str_c(collapse = ", ")
        }
      }
      
      reqDF <- reqDF %>% 
        mutate(FileName = fileNames[listInd],
               Resource = ifelse(ResourceLine == "", NA, Resource),
               UserName = ifelse(UserNameLine == "", NA, UserName),
               ReqStartMine = NULL,
               ReqFinishMine = NULL) %>% 
        filter(!is.na(ResourceLine)) %>% 
        filter(ResourceLine != "")
      
      resultList[[listInd]] <- reqDF
      rm(text)
      rm(reqDF)
    }
  
  resultList %>% 
    return()
}