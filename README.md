# FIBOS
## Description
The FIBOS package was developed with the objective of enabling the use of the Occluded Surface methodology, created by Patrick Fleming, in environments other than Fortran. Additionally, we added a new way of generating dots, which allows for better symmetry between the atoms of protein molecules.
## Functionalities
The package allows for the calculation of occluded areas between atoms of a molecule, using an input PDB file. For this, two methodologies can be used: OS or FIBOS. In both, contact area data is generated, and consequently, the file containing information regarding the calculation results based on the selected methodology.
## Requirements
Firstly, it is necessary to have devtools installed in Rstudio:
install.packages(“devtools”)
Note: Please note that the package requires some additional libraries such as:
  * bio3d
  * dplyr
  * readr
  * stringr
  * tidyr
## How use
## Authors
## Status
In Progress.
