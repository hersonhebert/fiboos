#' @title Reorganization of PDB file.
#' @name clean_pdb
#'
#' @description It's a necessary function to help in the proccess to read file and calculate areas.
#' @param path_pdb Name or path of PDB file.
#' @param online Tag to describes if the read will be obtained of Online Way.
#'
#' @author Herson Hebert
#'
#' @importFrom bio3d get.pdb
#' @importFrom bio3d read.pdb
#' @importFrom bio3d write.pdb
#'
clean_pdb = function(path_pdb, online){
  if(!file.exists(path_pdb)){
    if(grepl(".pdb", path_pdb) && online){
      bio3d::get.pdb(gsub(".pdb","",path_pdb))
    } else if(online && !grepl(".pdb","",path_pdb)){
      bio3d::get.pdb(path_pdb)
      path_pdb = paste(path_pdb,".pdb",sep = "")
    }
  }
  file.rename(path_pdb, "temp1.pdb")
  cmd = system.file("scripts","clean.csh", package = "osfibo")
  cmd_1 = paste("chmod +x ",cmd, sep = "")
  system(cmd_1)
  system(cmd)
  file.remove("temp1.pdb")
  dyn.load(system.file("libs", "osfibo.so", package = "osfibo"))
  .Fortran("renum", PACKAGE = "osfibo")
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
  dyn.unload(system.file("libs", "osfibo.so", package = "osfibo"))
  return(interval)
}
