shinyServer(function(input, output, session) {
  source(findmypath("app/scripts", "server_data.R"),local=T)
  source(findmypath("app/scripts", "server_info.R"),local=T)
  source(findmypath("app/scripts", "server_plot_properties.R"),local=T)
  source(findmypath("app/scripts", "server_plot_data.R"),local=T)
  source(findmypath("app/scripts", "server_plot_flexi.R"),local=T)
  source(findmypath("app/scripts", "server_export.R"),local=T)
  source(findmypath("app/scripts", "server_info.R"),local=T)
  source(findmypath("app/scripts", "server_images.R"),local=T)
  source(findmypath("app/scripts", "server_script.R"),local=T)
  ##################################################################
  observe({
    data=fdata()
    updateSelectInput(session,"subsetvar",
                      choices=c("none",as.vector(colnames(data))),
                      selected="none")
    updateSelectInput(session,"subsetlev",
                      choices=c(""),
                      selected="")
    updateSelectInput(session,"var",
                      choices=colnames(data),
                      selected=colnames(data)[1])
    updateSelectInput(session,"xvar",
                      choices=c("none",colnames(data)),
                      selected="none")
  })
  observe({
    subsetvar=input$subsetvar
    data=isolate(fdata())
    if(subsetvar=="none"){
      updateSelectInput(session, "subsetlev",
                        choices=c(""),
                        selected="")
    }
    if(subsetvar!="none"){
      var=data[[subsetvar]]
      lev=sort(unique(as.vector(var)))
      updateSelectInput(session, "subsetlev",
                        choices=lev,
                        selected=lev[1])
    }
  })
  observe({
    data=fdata_s()
    vars=c("none",colnames(data))
    updateSelectInput(session,"varx",choices=vars,selected=vars[2])
    updateSelectInput(session,"vary",choices=vars,selected=vars[1])
  })
  
  logp1=function(){
    trans=function(x) log(x+1)
    inv=function(x) exp(x)-1
    scales::trans_new(name="logp1",trans,inv,domain=c(-1,Inf))
  }
  
  percent=function(){
    scales::percent
  }
  f_update_input=function(arg,layer){
    nameinput=paste0("type",arg,layer)
    if(!is.null(input[[nameinput]])){
    type=input[[nameinput]]
    data=fdata_s()
    datatypes=fdatatypes()
    vars=colnames(data)[which(datatypes=="factor")]
    if(arg=="size"){vars=colnames(data)[which(datatypes=="numeric")]}
    if(type=="map"){updateSelectInput(session,paste0("map",arg,layer),
                                      choices=vars,
                                      selected=vars[1])}
    }
  }
  observe({f_update_input("color",    layer=1)})
  observe({f_update_input("size",     layer=1)})
  observe({f_update_input("shape",    layer=1)})
  observe({f_update_input("fill",     layer=1)})
  observe({f_update_input("linetype", layer=1)})
  observe({f_update_input("color",    layer=2)})
  observe({f_update_input("size",     layer=2)})
  observe({f_update_input("shape",    layer=2)})
  observe({f_update_input("fill",     layer=2)})
  observe({f_update_input("linetype", layer=2)})
  observe({f_update_input("color",    layer=3)})
  observe({f_update_input("size",     layer=3)})
  observe({f_update_input("shape",    layer=3)})
  observe({f_update_input("fill",     layer=3)})
  observe({f_update_input("linetype", layer=3)})
  
  observe({x=input$varx;y=input$vary;updateTextInput(session,"xmin",value="")})
  observe({x=input$varx;y=input$vary;updateTextInput(session,"xmax",value="")})
  observe({x=input$varx;y=input$vary;updateTextInput(session,"ymin",value="")})
  observe({x=input$varx;y=input$vary;updateTextInput(session,"ymax",value="")})
  
  observe({
    x=input$varx
    y=input$vary
    updateTabsetPanel(session, "general",selected=2)
    updateTabsetPanel(session, "tabset_prop", selected="tab_prop_layer1")
    updateTabsetPanel(session, "tabset_show", selected="tab_show_alllayers")
  })
  
  observe({
    combi=rawcombi()
    x=input$varx
    y=input$vary
    if(combi %in% c("nonefactor","nonenumeric","numericfactor")){
      updateSelectInput(session,"varx",selected=y)
      updateSelectInput(session,"vary",selected=x)
    }
  })
  
  observe({
    x=input$varx; if(x=="none"){x=""}
    y=input$vary; if(y=="none"){y=""}
    name=paste0(x,"_",y)
    if(y==""){name=x}
    if(x==""){name=y}
    updateTextInput(session,inputId="graph_filename",value=name)
  })
})