output$myscript=renderText({
  text="<h4> Copy and paste to R to reproduce graph:</h4>"
  if(!is.null(input$file)){
    lineread=paste0("read.csv('",
                input$file$name,
                "',header=",input$header,
                ",sep='",input$sep,
                "',dec='",input$dec,
                "',na.strings='",input$na.strings,
                "')")
  }
  if(is.null(input$file)){
    lineread="read.csv('catdata.csv'),sep=';')"
  }
  script=c("### Read data file:",
           lineread,
           plot_flexi())
  for (i in 1:length(script)){
    text=paste0(text,paste0("<p>",script[i],"</p>"))
  }
  text
})