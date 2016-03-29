# graphiT

graphiT is a package which allows you to launch an interactive application, the Graphics ToolKat, via a simple call to the function graphiT:

```r
graphiT()
```

## Installation

For now there is no stable version of this package on CRAN. If you want to install the dev version run:

```r
if(!require(devtools)){install.packages("devtools")}
devtools::install_github("lvaudor/graphiT")
```

## Use

```r
library(graphiT)
graphiT()
```