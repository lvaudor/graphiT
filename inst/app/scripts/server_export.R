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
    fgraph(file,width=input$width,height=input$height)
    plot_flexi()
    dev.off()
  }
)