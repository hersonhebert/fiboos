#' @title PDB Cleaning.
#' @name clean_pdb
#'
#' @description Cleaning PDB performs the reorganization of data from an input
#'              PDB file. This function is responsible for removing lines and
#'              information that are not necessary for calculating occluded
#'              areas. In addition, the residues and their atoms are renumbered
#'              to perform the area calculations.
#'
#' @param path_pdb Input containing only the name of the 4-digit PDB file, the file will be obtained online. If there is an extension ".pdb" or full path, the file will be obtained locally.
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#'
#' @importFrom bio3d get.pdb
#' @importFrom bio3d read.pdb
#' @importFrom bio3d write.pdb
#'
clean_pdb = function(path_pdb){
   if(!file.exists(path_pdb)){
     if(!grepl(".pdb","",path_pdb)){
       bio3d::get.pdb(path_pdb)
       path_pdb = paste(path_pdb,".pdb",sep = "")
     }
   }
  file.rename(path_pdb, "temp1.pdb")
  cmd = system.file("scripts","clean.csh", package = "os")
  cmd_1 = paste("chmod +x ",cmd, sep = "")
  system(cmd_1)
  system(cmd)
  file.remove("temp1.pdb")
  dyn.load(system.file("libs", "os.so", package = "os"))
  .Fortran("renum", PACKAGE = "os")
  file.rename("new.pdb", "temp.pdb")
  file.remove("temp1.cln")
  pdb = bio3d::read.pdb("temp.pdb")
  resno = pdb$atom$resno[1]-1
  for(i in 1:length(pdb$atom$resno)){
    pdb$atom$resno[i] = pdb$atom$resno[i]-resno
  }
  bio3d::write.pdb(pdb, "temp.pdb")
  iresf = as.integer(pdb$atom$resno[1])
  iresl = as.integer(pdb$atom$resno[length(pdb$atom$resno)])
  interval = c(iresf,iresl)
  dyn.unload(system.file("libs", "os.so", package = "os"))
  return(interval)
}
