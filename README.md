# graphiT

graphiT is a package which allows you to launch an interactive application, the Graphics ToolKat, via a simple call to the function graphiT:

```r
graphiT()
```

## Installation

For now there is no stable version of this package on CRAN. If you want to install the dev version, make sure you have a very recent version of R (>3.2.2) and run:

```r
if(!require(devtools)){install.packages("devtools")}
devtools::install_github("lvaudor/graphiT")
```

The devtools::install_github command might fail due to connection issues if you access the internet through a proxy. If so, get your proxy settings from your organizations's IT services and run the following:

```r
library(httr)
set_config(use_proxy(url="xxxx",port=XXXX))
```

or, if your proxy requires authentification:

```r
library(httr)
set_config(use_proxy(url="xxxx",port=XXXX,username="xxxx",password="xxxx"))
```

## Use

To launch graphiT from your R console simply run:

```r
library(graphiT)
graphiT()
```