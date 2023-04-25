# OS
## Description
The OS package was developed with the objective of enabling the use of the Occluded Surface methodology, created by Patrick Fleming, in environments other than Fortran. Additionally, we added a new way of generating dots, which allows for better symmetry between the atoms of protein molecules.
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
### Installing the Package

library(devtools)

install_github(“https://github.com/hersonhebert/os”)

### Using the Package:

Currently, the package is limited to two functions: occluded_surface and read_OS In this discussion, we will cover the use of each of these functions separately. Let's begin with occluded_surface:

library(byo3d)
library(dplyr)
library(readr)
library(stringr)
library(tidyr)

m = occluded_surface(pdb, method)

The function is responsible for computing the occluded areas between atoms and returning the results as a tibble. Additionally, it generates the prot.srf file as a side effect.

Regarding the parameters:

  - pdb: this can either be the code or path/file of the PDB that represents a protein. If you wish to obtain the file online from the RCSB PDB site, simply enter the PDB code. If the file is saved locally, enter the file path.

  - method: this parameter determines the method used to calculate the occluded areas between atoms. Accepts the strings "OS" or "FIBOS"

The other function reads an OS prot.srf file:

m = read_OS(file)

  - file: the path to the prot.srf file.

## Examples

m.os = occluded_surface("1ppf", method = "OS")

m.fibos = occluded_surface("data/1ppf.pdb", method = "FIBOS")

m = read_OS("prot.srf")

### Function return (occluded_surface and read_OS):

![alt text](Pictures/print_return.png)

## Authors

- Carlos da Silveira  carlos.silveira@unifei.edu.br
- Herson Soares d2020102075@unifei.edu.br

## References

Pattabiraman, N., Ward, K. B., & Fleming, P. J. (1995). Occluded molecular surface: Analysis of protein packing. Journal of Molecular Recognition, 8, 334–344. https://doi.org/doi.org/10.1002/jmr.300080603

## Status
In Progress.
