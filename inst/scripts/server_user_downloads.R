output$dltabclassif <- downloadHandler(
  filename=function(){"Tab_Classif_Results.csv"},
  content=function(file){
    mydata=tab_clust()
    write.table(mydata,
                file,
                sep=";",
                row.names=FALSE)}
)
output$dlfigclassifseries <- downloadHandler(
  filename=function(){name=paste0("Fig_Classif_series.",
                                  input$graph_format)},
  content=function(file){
    fgraph=get(input$graph_format)
    fgraph(file,width=input$width,height=input$height)
    plot_clust()
    dev.off()
  }
)

output$dlfigclassiftree <- downloadHandler(
  filename=function(){name=paste0("Fig_Classif_series.",
                                  input$graph_format)},
  content=function(file){
    fgraph=get(input$graph_format)
    fgraph(file,width=input$width,height=input$height)
    plot_tree()
    dev.off()
  }
)
