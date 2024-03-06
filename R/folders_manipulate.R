#' @title Files Manipulating.
#' @name create_folder
#'
#' @description Function for creating folders and manipulating files in the FIBOS system.
#'
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming
#'
create_folder = function(){
  if(!file.exists("fibos_files") & basename(getwd())!="fibos_files"){
    dir.create("fibos_files")
    setwd("fibos_files/")
  }
  if(basename(getwd())!="fibos_files" & file.exists("fibos_files")){
    setwd("fibos_files/")
  }
}

change_files = function(pdb_name){
  if(grepl(".pdb",pdb_name)==TRUE){
    pdb_name = gsub(".pdb","", pdb_name)
  }
  if(file.exists("raydist.lst")){
    name = paste("raydist_",pdb_name,".lst", sep = "")
    file.rename("raydist.lst", name)
  }
  if(file.exists("prot.srf")){
    name = paste("prot_",pdb_name,".srf", sep = "")
    file.rename("prot.srf", name)
  }
}
