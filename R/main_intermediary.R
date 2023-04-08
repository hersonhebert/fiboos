#' @title Reading Values of Occluded Surface Area.
#' @name execute_os
#'
#' @description It's a important function to load calculated values to use of user.
#' @param iresf Name or path of prot.srf.
#' @param iresl Name or path of prot.srf.
#' @param maxres Maximum number of residues.
#' @param maxat Maximum number of atoms.
#'
#' @importFrom stats rnorm
#'
#' @author Herson Hebert
#'
call_main = function(iresf, iresl, maxres, maxat){
  resnum = integer(maxres)
  x = double(maxat)
  y = double(maxat)
  z = double(maxat)
  main_75 = .Fortran("main", resnum = as.integer(resnum), natm = as.integer(0),
                     x=as.double(rnorm(maxat)) ,y = as.double(rnorm(maxat)),
                     z = as.double(rnorm(maxat)), iresf, iresl, PACKAGE = "osfibo")
  return(main_75)
}

execute_os = function(iresf, iresl){
  maxres = 10000
  maxat = 50000
  dyn.load(system.file("libs", "osfibo.so", package = "osfibo"))
  main_75 = call_main(iresf, iresl, maxres, maxat)
  for(ires in iresf:iresl){
    intermediate = .Fortran("main_intermediate", main_75$x, main_75$y,
                            main_75$z, as.integer(ires), main_75$resnum,
                            main_75$natm, PACKAGE = "osfibo")
    .Fortran("main_intermediate01",x=as.double(rnorm(maxat)),
             y = as.double(rnorm(maxat)),
             z = as.double(rnorm(maxat)), as.integer(ires), main_75$resnum,
             main_75$natm, PACKAGE = "osfibo")
    .Fortran("runSIMS", PACKAGE = "osfibo")
    .Fortran("surfcal", PACKAGE = "osfibo")
  }
  .Fortran("main_intermediate02", PACKAGE = "osfibo")
  dyn.unload(system.file("libs", "osfibo.so", package = "osfibo"))
}
