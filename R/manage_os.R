#' @title Calcule the Surface
#' @name calcule_surface
#'
#' @description This function, implements and execute all functions essentials
#' to run the OSFIBO code. One can reorganize the PDB file, to generate datas
#' about contacts of proteins and theirs areas of contact. The return of function is
#' a group of informations that contains all areas and contacts.
#'
#' @param path_pdb Path or name of PDB File
#' @param online Field to define if the file will be otain in a online way.
#'
#' @author Herson Hebert
#'
#' @export
calcule_surface = function(path_pdb, online){
  if(file.exists("prot.srf")){
    file.remove("prot.srf")
  }
  if(file.exists("temp.pdb")){
    file.remove("temp.pdb")
  }
  path = system.file("extdata", "radii", package = "osfibo")
  file.copy(from = path, to = getwd())
  interval = clean_pdb(path_pdb, online)
  iresf = interval[1]
  iresl = interval[2]
  execute_os(iresf, iresl)
  remove_files()
}

remove_files = function(){
  files_list = dir(pattern = ".ms")
  file.remove(files_list)
  files_list = dir(pattern = ".inp")
  file.remove(files_list)
  files_list = dir(pattern = ".txt")
  file.remove(files_list)
  file.remove("file.srf")
  file.remove("fort.6")
  file.remove("part_i.pdb", "part_v.pdb")
  file.remove("radii")
}

