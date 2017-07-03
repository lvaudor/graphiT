require(shiny)
require(ggplot2)


findmypath=function(dir="",file=""){
  path=paste0("../",dir,"/",file)
  if(dir==""){path=file}
  if(file==""){path=dir}
  return(path)
}



f_geom_label=function(geom){
  HTML(paste0("<img src='",geom,".png'>"))
}

f_color_label=function(color){
  HTML(paste0("<img src='color_",color,".png'>"))
}

f_palette_label=function(palette){
  HTML(paste0("<img src='palette_",palette,".png'>"))
}

mycolors=function(){
  mycolors=c("black",
             "darkgrey",
             "white",
             "red",
             "green",
             "yellow",
             "blue",
             "orange",
             "pink",
             "gold",
             "orchid2")
}

mypalettes=function(){
  mypalettes=c("Blues",
               "Greens",
               "Reds",
               "Greys",
               "Oranges",
               "Purples",                
#                "BuGn",
#                "BuPu",
#                "GnBu",
#                "OrRd", 
#                "RdPu",
#                "YlGn",
#                "BrBG",
#                "PiYG",
#                "PRGn",
#                "PuOr",
#                "PuBu",
#                "PuRd",
#                "RdBu",
#                "RdGy",                
#                "RdYlBu",
#                "RdYlGn",
#                "YlGnBu",
#                "YlOrBr",
#                "YlOrRd",
#                "PuBuGn",
               "Spectral")
  return(mypalettes)
}


striptovalue=function(chain){
  patterns_to_strip=c("<img src='",
                      "color_",
                      "palette_",
                      "linetype_",
                      "shape_",
                      "sides_",
                      ".png'>")
  for(i in 1:length(patterns_to_strip)){
  chain=gsub(x=chain,
             pattern=patterns_to_strip[i],
             replacement="")
  }
  return(chain)
}
