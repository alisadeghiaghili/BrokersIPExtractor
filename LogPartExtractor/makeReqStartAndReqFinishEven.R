makeReqStartAndReqFinishEven <- function(reqStarts, reqFinishes) {
  if (length(reqStarts) > length(reqFinishes)) {
    reqFinishes <- c(reqFinishes, NA)
  } else if (length(reqStarts) < length(reqFinishes)) {
    reqStarts <- c(NA, reqStarts)
  }
  
  return(list(reqStarts = reqStarts,
         reqFinishes = reqFinishes))
}