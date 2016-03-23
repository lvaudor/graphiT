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
  if(input$infoXY%%2!=0){
    wellPanel(includeHTML(findmypath("scripts", "infoXY.html")))
  }
})

output$infoGraphtype=renderUI({
  if(input$infoGraphtype%%2!=0){
    wellPanel(includeHTML(findmypath("scripts", "infoGraphtype.html")))
  }
})



