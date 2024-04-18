#' @title Files Manipulating.
#' @name create_folder
#'
#' @description Function for creating folders and manipulating files in the FIBOS system.
#'
#'
#' @author Carlos Henrique da Silveira (carlos.silveira@unifei.edu.br)
#' @author Herson Hebert Mendes Soares (hersonhebert@hotmail.com)
#' @author João Paulo Roquim Romanelli (joaoromanelli@unifei.edu.br)
#' @author Patrick Fleming (Pat.Fleming@jhu.edu)
#'
create_folder = function(){
  if(!file.exists("fibos_files")){
    dir.create("fibos_files")
  }
}

change_files = function(pdb_name){
  if(grepl(".pdb",pdb_name)==TRUE){
    pdb_name = gsub(".pdb","", pdb_name)
    if(nchar(pdb_name)>4){
      pdb_name = substr(pdb_name, nchar(pdb_name)-3, nchar(pdb_name))
    }
  }
  name_pdb = pdb_name
  name_raydist = pdb_name
  if(file.exists("prot.srf") == TRUE){
    file.copy("prot.srf", "fibos_files/")
    file.remove("prot.srf")
    name_pdb = paste("fibos_files/prot_",pdb_name,".srf", sep = "")
    file.rename("fibos_files/prot.srf", name_pdb)
  }
  if(file.exists("raydist.lst") == TRUE){
    file.copy("raydist.lst", "fibos_files/")
    file.remove("raydist.lst")
    name_raydist = paste("fibos_files/raydist_",pdb_name,".lst", sep = "")
    file.rename("fibos_files/raydist.lst", name_raydist)
  }
  return(name_pdb)
}
