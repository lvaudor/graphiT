output$dl_fig <- downloadHandler(
  filename=function(){
    name=paste0(input$graph_filename,".",input$graph_format)
    return(name)
  },
  content=function(file){
    if(input$graph_format=="eps"){fgraph=postscript}
    if(input$graph_format!="eps"){
      fgraph=get(input$graph_format)
    }
    print(input$width)
    print(input$height)
    fgraph(file,width=input$exportwidth,height=input$exportheight)
    plot_flexi()
    dev.off()
  }
)