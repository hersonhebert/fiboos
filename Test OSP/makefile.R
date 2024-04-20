library(os)
library(readr)
if(1){
  file = readLines("table_4.dat")
  means_file = "all_means.dat"
  con_means = file(means_file,"w")
  for(item in file){
    occluded_surface(item,"os")
    osp = respak("prot.srf")
    osp = osp$OSP
    mean_item = mean(osp)
    name_file = paste(item,"_pak_R.dat",sep = "")
    line_means = paste(item,mean_item)
    writeLines(line_means,con_means)
    con = file(name_file,"w")
    writeLines(as.character(osp),con)
    close(con)
  }
  close(con_means)
  file.remove("prot.pak")
  file.remove("prot.srf")
  file.remove("temp.pdb")
}
  