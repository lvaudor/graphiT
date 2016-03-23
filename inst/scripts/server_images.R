output$mylogo <- renderImage({
  list(src=findmypath("www","graphics_toolkat_smalllogo.png"),
                       width="300px",height="300px")
}, deleteFile = FALSE)

output$symbol_shapes <- renderImage({
  list(src=findmypath("www","symbol_shapes.png"),
       width="225px",height="212px")
}, deleteFile = FALSE)

elems=c("bar",
       "bin2d",
       "boxplot",
       "density",
       "density2d",
       "dotplot",
       "freqpoly",
       "hex",
       "histogram",
       "jitter",
       "point",
       "quantile",
       "rug",
       "smooth",
       "violin")
list_geoms=paste0("geom_",elems)
for(x in 1:length(list_geoms)){
  local({  ## sans le "local" tous les outputs renvoient sur une meme image
  i=x
  output[[list_geoms[i]]]=renderImage({
    file=paste0("geom_",elems[i],".png")
    list(src=findmypath("www",file),width="60px",height="50px")
  },deleteFile=FALSE)
  })
}

for(x in 1:10){
  local({  ## sans le "local" tous les outputs renvoient sur une meme image
    i=x
    output[[paste0("catpaw",i)]]=renderImage({
      list(src=findmypath("www","catpaw.png"),width="18px",height="28px")
    },deleteFile=FALSE)
  })
}

