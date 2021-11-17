createShinyDT <- function(result) {
  renderDT(
    datatable(result,
              options = list(
                dom = "lBftrip",
                buttons = c('csv', 'excel'),
                server = FALSE,
                lengthMenu = c(10, 25, 50, 100), 
                pageLength = 100
              ),
              extensions = 'Buttons',
              selection = 'single',        ## enable selection of a single row
              filter = c("top"),              ## include column filters at the top
              rownames = TRUE,             ## show row numbers/names
      )
    )%>% 
  return()
}