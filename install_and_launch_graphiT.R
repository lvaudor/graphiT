#depuis projet graphiT.proj
setwd("..")

devtools::document("graphiT")

#devtools::use_vignette("graphiT_vignette",pkg="graphiT")
devtools::install("graphiT")

require(graphiT)
#devtools::load_all("graphiT")
graphiT()

#build("graphiT",binary=TRUE
