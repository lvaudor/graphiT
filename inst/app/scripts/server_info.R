output$infoLoad=renderUI({
  if(input$infoLoad%%2!=0){
    wellPanel(includeHTML(findmypath("scripts", "infoLoad.html")))
  }
})

output$infoSubset=renderUI({
  if(input$infoSubset%%2!=0){
    wellPanel(includeHTML(findmypath("scripts", "infoSubset.html")))
  }
})

output$infoXY=renderUI({
    includeHTML(findmypath("scripts", "infoXY.html"))
})


output$infoGeom1=renderUI({
  HTML(info_geoms()[[rgeom1()]])
})
output$infoGeom2=renderUI({
  HTML(info_geoms()[[rgeom2()]])
})
output$infoGeom3=renderUI({
  HTML(info_geoms()[[rgeom3()]])
})