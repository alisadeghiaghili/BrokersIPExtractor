cleanFinalDf <- function(resultList) {
  bind_rows(resultList) %>% 
    mutate(UserName = UserName %>% 
             str_replace_all(pattern = ", ,", replacement = "") %>% 
             str_replace_all(pattern = ", \\[", replacement = "") %>% 
             str_trim() %>% 
             str_replace(pattern = "\\]\\s+", replacement = " ") %>% 
             str_replace_all(pattern = '\\"name\\",\\"', replacement = "") %>% 
             str_replace_all(pattern = '\\]', replacement = " ") %>% 
             str_replace_all(pattern = '\\"', replacement = "") %>% 
             str_replace(pattern = " \\s+,$", replacement = "") %>% 
             str_replace_all(pattern = " \\[", replacement = " ") %>% 
             str_trim() %>% 
             str_replace_all(pattern = " \\s+", replacement = ", ")) %>% 
  return()
}