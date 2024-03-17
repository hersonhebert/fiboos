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
    system_arch_1 = Sys.info()
    if(system_arch_1["sysname"] == "Linux"){
      dyn.load(system.file("libs", "fibos.so", package = "fibos"))
    } else if(system_arch_1["sysname"] == "Windows"){
      if(system_arch_1["machine"] == "x86-64"){
        dyn.load(system.file("libs/x64", "fibos.dll", package = "fibos"))
      } else{
        dyn.load(system.file("libs/x86", "fibos.dll", package = "fibos"))
      }
    }
    .Fortran("respak", PACKAGE = "fibos")
    if(system_arch_1["sysname"] == "Linux"){
      dyn.unload(system.file("libs", "fibos.so", package = "fibos"))
    } else if(system_arch_1["sysname"] == "Windows"){
      if(system_arch_1["machine"] == "x86-64"){
        dyn.unload(system.file("libs/x64", "fibos.dll", package = "fibos"))
      } else{
        dyn.unload(system.file("libs/x86", "fibos.dll", package = "fibos"))
      }
    }
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
