output$myscript=renderText({
  text="<h4> Copy and paste to R to reproduce graph:</h4>"
  if(!is.null(input$file)){
    lineread=paste0("data=read.csv('",
                input$file$name,
                "',header=",input$header,
                ",sep='",input$sep,
                "',dec='",input$dec,
                "',na.strings='",input$na.strings,
                "')")
  }
  if(is.null(input$file)){
    lineread="data=read.csv('catdata.csv'),sep=';')"
  }
  linesubset=""
  if(input$subsetvar!="none" & input$subsetlev!=""){
    linesubset=paste0("data=data[which(",
                      input$subsetvar,
                      "=='",
                      input$subsetlev,
                      "'),]")
  }
  script=c("### Read, subset, and attach data file:",
           lineread,
           linesubset,
           "attach(data)",
           plot_flexi())
  for (i in 1:length(script)){
    text=paste0(text,paste0("<p>",script[i],"</p>"))
  }
  text
})