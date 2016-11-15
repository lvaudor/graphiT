output$mylogo <- renderImage({
  list(src=findmypath("app/images","graphics_toolkat_smalllogo.png"),
                       width="300px",height="300px")
}, deleteFile = FALSE)

output$symbol_shapes <- renderImage({
  list(src=findmypath("app/images","symbol_shapes.png"),
       width="225px",height="212px")
}, deleteFile = FALSE)


for(x in c(1:7,"layer1","layer2","layer3")){
  local({  ## sans le "local" tous les outputs renvoient sur une meme image
    i=x
    output[[paste0("catpaw",i)]]=renderImage({
      list(src=findmypath("app/images","catpaw.png"),width="18px",height="28px")
    },deleteFile=FALSE)
  })
}

