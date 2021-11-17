extractResourceTypes <- function(text, ResourceLines) {
  str_extract_all(string = text[c(ResourceLines)], pattern = "post|get|delete") %>% 
    unlist() %>% 
    str_c(collapse = ", ") %>% 
    return()
}