importLog <- function(logsPath, fileName) {
  source("readLog.R")
  source("makeCaseInsensitive.R")
  
  readLog(logsPath = logsPath, fileName = fileName) %>% 
    makeCaseInsensitive() %>% 
    return()
}