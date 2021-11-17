extractFileNames <- function(logsPath){
  dir(logsPath) %>% 
    str_extract_all(pattern = ".*\\.(log|txt)$") %>% 
    unlist() %>% 
    return()
}