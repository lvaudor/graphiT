#' Launch the Graphic ToolKat
#'
#' This function allows you to launch the Graphic ToolKat. This is a Shiny App designed to help users produce ggplot graphics.
#' @keywords bwegek
#' @export
#' @examples
#' graphiT()

graphiT=function(){
  shiny::shinyApp(
    server=function(input, output, session) {
      source(findmypath("scripts", "server_data.R"),local=T)
      source(findmypath("scripts", "server_info.R"),local=T)
      source(findmypath("scripts", "server_plot_data.R"),local=T)
      source(findmypath("scripts", "server_plot_flexi.R"),local=T)
      source(findmypath("scripts", "server_export.R"),local=T)
      source(findmypath("scripts", "server_info.R"),local=T)
      source(findmypath("scripts", "server_images.R"),local=T)
      ##################################################################
      xfacet=reactive({
        data=fdata_s
        var=data[,which(colnames(data)==input$xfacet)]
        return(var)
      })
      ########
      yfacet=reactive({
        data=fdata_s
        var=data[,which(colnames(data)==input$yfacet)]
        return(var)
      })

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

      logp1_trans=function(){
        trans=function(x) log(x+1)
        inv=function(x) exp(x)-1
        scales::trans_new(name="logp1",trans,inv,domain=c(-1,Inf))
      }
      f_update_input=function(input,arg){
        type=input[[paste0("type",arg)]]
        data=fdata_s()
        datatypes=fdatatypes()
        vars=colnames(data)[which(datatypes=="factor")]
        if(arg=="size"){vars=colnames(data)[which(datatypes=="numeric")]}
        if(type=="map"){updateSelectInput(session,paste0("map",arg),choices=vars,selected=vars[1])}
      }
      observe({arg="color";   f_update_input(input,arg)})
      observe({arg="size";    f_update_input(input,arg)})
      observe({arg="shape";   f_update_input(input,arg)})
      observe({arg="fill";    f_update_input(input,arg)})
      observe({arg="linetype";f_update_input(input,arg)})

      observe({
        x=input$varx; if(x=="none"){x=""}
        y=input$vary; if(y=="none"){y=""}
        name=paste0(x,"_",y)
        if(y==""){name=x}
        if(x==""){name=y}
        updateTextInput(session,inputId="graph_filename",value=name)
      })
    },#server
    ui=shiny::fluidPage(
      tabsetPanel(
        source(findmypath("scripts", "ui_presentation.R"))$value,
        source(findmypath("scripts", "ui_data.R"))$value,
        source(findmypath("scripts", "ui_plot.R"))$value,
        source(findmypath("scripts", "ui_export.R"))$value
      )#tabsetPane
    )#ui
  )
}

