#' @title Calcule the Surface
#' @name occluded_surface
#'
#' @description The calculation of occluded surface areas is essential for
#'              understanding the possibility of an enzyme passing between atoms
#'              of a protein. To perform the calculation, it is considered that
#'              a surface is occluded based on tests with a probe, which is
#'              typically the water molecule.
#'
#' @param path_pdb Path or name of PDB File
#' @param online Logical parameter that defines whether to download or locally load the PDB file.
#' @param method Method to be used - 1: OS ; 2: FIBOS
#'
#' @seealso [read_prot()]
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#'
#' @export
occluded_surface = function(path_pdb, online, method){
  if(file.exists("prot.srf")){
    file.remove("prot.srf")
  }
  if(file.exists("temp.pdb")){
    file.remove("temp.pdb")
  }
  path = system.file("extdata", "radii", package = "fibos")
  file.copy(from = path, to = getwd())
  interval = clean_pdb(path_pdb, online)
  iresf = interval[1]
  iresl = interval[2]
  execute(iresf, iresl, method)
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
}

