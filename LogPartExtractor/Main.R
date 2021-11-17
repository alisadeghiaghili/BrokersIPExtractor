options(warn=-1)
source("loadPrequisits.R")

logsPath <- choose.dir(caption = "select the logs path")
resource <- readline(prompt = "enter the resource you are looking for: ")

result <- extractLogParts(logsPath, resource) %>% 
  cleanFinalDf()

ui <- shinyUI()

server <- function(input, output) {
  output$tbl = createShinyDT(result)
}

shinyApp(ui = ui, server = server)