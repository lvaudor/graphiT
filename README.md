# graphiT

An interactive application to produce graphics in R

The graphiT package comes with a function graphiT which launches an interactive application that help users with the production of graphics in R (relying on package ggplot).


## Installation

For now there is no stable version from CRAN. If you want to install the dev version run (after making sure you have a recent version of R, ie. R 3.2.x):
  
```r
install.packages("devtools")  # If necessary
devtools::install_github("lvaudor/graphiT")
```


## Use

```r
library(graphiT)
graphiT()
```