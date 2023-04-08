#' @title Reading Values of Occluded Surface Area.
#' @name read_prot
#'
#' @description It's a important function to load calculated values to use of user.
#'
#' @author Herson Hebert
#'
#' @importFrom readr read_fwf
#' @importFrom dplyr filter
#' @importFrom dplyr rename
#' @importFrom stringr str_count
#' @importFrom tidyr separate
#'
#' @export
read_prot = function(){
  dado = read_fwf("prot.srf")
  dado = filter(dado, X1 == "INF")
  dado$X7 = NULL
  dado = rename(dado, INF = X1, ATOM = X2, NUMBER_POINTS = X3, AREA = X4, RAYLENGTH = X5, DISTANCE = X6)
  dado$NUMBER_POINTS = gsub("\\s\\pts","", dado$NUMBER_POINTS)
  dado$AREA = gsub("\\s\\A2","", dado$AREA)
  dado$RAYLENGTH = gsub("\\s\\Rlen","", dado$RAYLENGTH)
  dado$NUMBER_POINTS = as.integer(dado$NUMBER_POINTS)
  dado$AREA = as.double(dado$AREA)
  dado$RAYLENGTH = as.double(dado$RAYLENGTH)
  dado$DISTANCE = as.double(dado$DISTANCE)
  return(dado)
}
