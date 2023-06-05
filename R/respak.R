#' @title Respak Calcule
#' @name respak
#'
#' @description The implemented function executes the implemented methods.
#'              Using this function, it is possible to calculate occluded areas
#'              through the traditional methodology, Occluded Surface, or by
#'              applying the Fibonacci OS methodology. At the end of the method
#'              execution, the "prot.srf" file is generated, and returned for
#'              the function. The data in this file refers to all contacts
#'              between atoms of molecules present in a protein's PDB.
#'
#' @param prot Prot File.
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
respak = function(){
  if(file.exists("prot.srf")){
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
