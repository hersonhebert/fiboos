#' @title Respak Calcule
#' @name respak
#'
#' @description The OSP value is important for verifying the quality of the values
#'              calculated by the developed package for calculating the contact
#'                areas between the molecules of the analyzed protein.
#'
#' @param file Prot File (.srf).
#'
#' @seealso [read_prot()]
#' @seealso [occluded_surface()]
#'
#' @importFrom readr read_table
#'
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming
#'
#' @export
respak = function(file){
  name = file
  if(file.exists(file)){
    if(file!="prot.srf"){
      file.rename(file,"prot.srf")
      file = "prot.srf"
    }
    dyn.load(system.file("libs", "fibos.so", package = "fibos"))
    .Fortran("respak", PACKAGE = "fibos")
    dyn.unload(system.file("libs", "fibos.so", package = "fibos"))
    osp = readr::read_table("prot.pak")
    file = gsub(".srf","",name)
    file = paste(file,".pak",sep = "")
    file.rename("prot.srf",name)
    file.rename("prot.pak",file)
    return(osp)
  }
  else{
    return(NULL)
  }
}
