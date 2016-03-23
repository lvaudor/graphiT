#depuis projet graphiT.proj

source("R/graphiT.R")

require(shiny)
require(rioja)
require(ggplot2)


findmypath=function(dir,file){
  path=paste0("inst/",dir,"/",file)
  print(path)
  return(path)
}

graphiT()
