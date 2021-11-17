concatResourceLines <- function(ResourceLines) {
  ResourceLines %>% as.character() %>% str_c(collapse = ", ")
}