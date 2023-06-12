#' @title Respak Calcule
#' @name respak
#'
#' @description The OSP value is important for verifying the quality of the values
#'              calculated by the developed package for calculating the contact
#'                areas between the molecules of the analyzed protein.
#'
#' @param prot Prot File (.srf).
#'
#' @seealso os::read_OS
#' @seealso os::occluded_surface
#'
#' @importFrom readr read_table
#'
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#'
#' @export
respak = function(file){
  if(file.exists(file)){
    dyn.load(system.file("libs", "os.so", package = "os"))
    .Fortran("respak", PACKAGE = "os")
    dyn.unload(system.file("libs", "os.so", package = "os"))
    osp = readr::read_table("prot.pak")
    return(osp)
  }
  else{
    print("Prot not Found.")
  }
}
