extractResourceLines <- function(text, dataDF, row, resource) {
  ResourceLines <- grep(x = text[dataDF[row, ]$ReqStartMine:dataDF[row, ]$ReqFinishMine], pattern = resource) + dataDF[row, ]$ReqStartMine - 1
  ResourceLines %>% 
    return()
}