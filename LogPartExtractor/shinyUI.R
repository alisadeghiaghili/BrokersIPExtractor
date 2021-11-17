shinyUI <- function() {
  ui <- fluidPage(
    titlePanel("LogPart Extractor"),
    # textInput('a', 'Resource'),
    DTOutput('tbl')
  )
  
  return(ui)
}