#depuis projet graphiT.proj
setwd("..")

devtools::document("graphiT")

require(tools)
deps<- package_dependencies(packages = c("shiny","ggplot2"),
                            db=available.packages(),
                            which = c("Imports","Depends"),
                            recursive = TRUE, reverse = FALSE)
deps=as.vector(unlist(deps))
deps=paste0(c("shiny","ggplot2",deps), collapse=",")


#devtools::use_vignette("graphiT_vignette",pkg="graphiT")
devtools::install("graphiT")

require(graphiT)
#devtools::load_all("graphiT")
graphiT()
