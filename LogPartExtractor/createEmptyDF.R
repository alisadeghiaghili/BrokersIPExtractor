createEmptyDF <- function() {
  data.frame("ReqStart" = as.numeric(NA), 
             "ReqFinish" = as.numeric(NA)) %>% 
    na.omit() %>% 
    return()
}