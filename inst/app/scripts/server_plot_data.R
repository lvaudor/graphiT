
output$plot=renderPlot({
      input$varx
      input$vary
      plot_flexi()
    },
    height=function(x){input$height},
    width=function(x){input$width}
)
output$plotexport=renderPlot({
  input$varx
  input$vary
  plot_flexi()
},
height=function(x){input$exportheight},
width=function(x){input$exportwidth}
)


output$layer1=renderPlot({
  input$varx
  input$vary
  plot_layer(1)
},
height=function(x){input$height},
width=function(x){input$width}
)
output$layer2=renderPlot({
  input$varx
  input$vary
  plot_layer(2)
},
height=function(x){input$height},
width=function(x){input$width}
)
output$layer3=renderPlot({
  input$varx
  input$vary
  plot_layer(3)
},
height=function(x){input$height},
width=function(x){input$width}
)


############################################
############################################
geom_type_UI_build=function(w,geom_choices,layer){
  myvalues=rep(FALSE,length(geom_choices))
  if(layer==1){myvalues[1]=TRUE}
 for(i in 1:length(geom_choices)){
    w=paste0(w,
             checkboxInput(inputId=paste0(geom_choices[i],layer),
                                  label=geom_choices[i],
                                  value=myvalues[i]),
             imageOutput(paste0(geom_choices[i],layer),width="100%", height="100%")
            )
 }
  return(w)
}


############################################
output$geom_layer1=renderUI({
  geom_choices=fgeom_choices(fcombi())
  radioButtons('chosengeom1', 'geom 1',
                choiceNames =lapply(geom_choices, "f_geom_label"),
                choiceValues=geom_choices,
                inline = TRUE)
})

output$geom_layer2=renderUI({
  geom_choices=fgeom_choices(fcombi())
  geom_choices=c("geom_none",geom_choices)
  radioButtons('chosengeom2', 'geom 2',
               choiceNames =lapply(geom_choices, "f_geom_label"),
               choiceValues=geom_choices,
               inline = TRUE)
})

output$geom_layer3=renderUI({
  geom_choices=fgeom_choices(fcombi())
  geom_choices=c("geom_none",geom_choices)
  radioButtons('chosengeom3', 'geom 3',
               choiceNames =lapply(geom_choices, "f_geom_label"),
               choiceValues=geom_choices,
               inline = TRUE)
})


rawcombi=reactive({
  data=fdata_s()
  datatypes=fdatatypes()
  i1=which(colnames(data)==input$varx)
  i2=which(colnames(data)==input$vary)
  ###
  t1="none";if(length(i1)>0){t1=datatypes[i1]}
  t2="none";if(length(i2)>0){t2=datatypes[i2]}
  if(t1=="integer"){t1="numeric"}
  if(t2=="integer"){t2="numeric"}
  if(length(i1)==0 & length(i2)==0){combi="none"}
  if(length(i1)>0|length(i2)>0){
    combi=paste0(t1,t2)
  }
  return(combi)
})
fcombi=reactive({
  combi=rawcombi()
  return(combi)
})


fgeom_choices=function(combi){
  if(combi=="none"){
    choices="geom_none"
  }
  if(combi=="numericnone"){
    choices=c(#"area",
      "geom_histogram",
      "geom_density",
      #"dotplot",
      "geom_freqpoly",
      "geom_rug"
      )
  }
  if(combi =="factornone"){
    choices=c("geom_bar"
              #"dotplot"
              )
  }
  if(combi=="factornumeric"){
    choices =c(
      "geom_boxplot",
      "geom_text",
      #"dotplot",
      "geom_violin",
      "geom_point",
      "geom_jitter",
      "stat_summary",
      "geom_rug")
  }
  if(combi=="numericnumeric"){
    choices = c("geom_point",
                "geom_text",
                "geom_line",
                "geom_area",
                "geom_jitter",
                "geom_rug",
                "geom_bin2d",
                "geom_density2d",
                "geom_smooth"
    )

  }
  if(combi=="factorfactor"){
    choices=c("geom_jitter",
              #"rug",
              "geom_bin2d",
              "geom_text")
  }
  return(choices)
}



rgeom1=reactive({
  elem="chosengeom1"
  geom="geom_none"
  if(!is.null(input[[elem]])){
    chain=input[[elem]]
    geom=striptovalue(chain)
  }
  return(geom)
})

rgeom2=reactive({
  elem="chosengeom2"
  geom="geom_none"
  if(elem %in% names(input)){
    geom=striptovalue(input[[elem]])
  }
  return(geom)
})

rgeom3=reactive({
  elem="chosengeom3"
  geom="geom_none"
  if(elem %in% names(input)){
    geom=striptovalue(input[[elem]])
  }
  return(geom)
})

################################################
output$continuouscolors=renderUI({
    allgeoms=c(rgeom1(),rgeom2(),rgeom3())
    if(!("geom_bin2d" %in% allgeoms)){
    myrow=fluidRow("This is useful only if one of the geoms is geom_bin2d, which is not the case here.")
    }
    if("geom_bin2d" %in% allgeoms){
      myrow=fluidRow(
            column(width=4,
                   radioButtons(inputId="continuous_colorscale",
                                label="continuous_colorscale",
                                choices=c("",
                                          "scale_fill_gradient",
                                          "scale_fill_gradient2",
                                          "scale_fill_gradientn"),
                                 selected="")
                   ),
            column(width=8,
                   conditionalPanel(
                     condition="input.continuous_colorscale=='scale_fill_gradient'",
                     fluidRow(
                       column(width=6,
                              radioButtons(inputId="low",
                                           label="low",
                                           choiceNames=lapply(mycolors(),"f_color_label"),
                                           choiceValues=mycolors(),
                                           selected='red')
                       ),#column
                       column(width=6,
                              radioButtons(inputId="high",
                                                    label="high",
                                                    choiceNames=lapply(mycolors(),"f_color_label"),
                                                    choiceValues=mycolors(),
                                                    selected="<img src='color_blue.png'>")
                       )#column
                     )#fluidRow
                   ),#conditionalPanel
                   conditionalPanel(
                     condition="input.continuous_colorscale=='scale_fill_gradient2'",
                     fluidRow(
                       column(width=4,
                              radioButtons(inputId="low2",
                                                    label="low",
                                                    choiceNames=lapply(mycolors(),"f_color_label"),
                                                    choiceValues=mycolors(),
                                                    selected="<img src='color_red.png'>")
                       ),#column
                       column(width=4,
                              radioButtons(inputId="mid",
                                                    label="mid",
                                                    choiceNames=lapply(mycolors(),"f_color_label"),
                                                    choiceValues=mycolors(),
                                                    selected="<img src='color_white.png'>")
                       ),#column
                       column(width=4,
                              radioButtons(inputId="high2",
                                                    label="high",
                                                    choiceNames=lapply(mycolors(),"f_color_label"),
                                                    choiceValues=mycolors(),
                                                    selected="<img src='color_blue.png'>")
                       )#column
                     )#fluidRow
                   ),#conditionalPanel
                   conditionalPanel(
                     condition="input.continuous_colorscale=='scale_fill_gradientn'",
                     fluidRow(
                       column(width=6,
                              radioButtons(inputId="colors",
                                                    label="colors",
                                                    choices=c("terrain.colors",
                                                              "heat.colors",
                                                              "topo.colors",
                                                              "cm.colors",
                                                              "rainbow"),
                                                    selected="rainbow")
                       ),#column
                       column(width=6,
                              textInput(inputId="ncolors",
                                        label="ncolors",
                                        value="5")
                       )#column
                      )#fluidRow
                    )#conditionalPanel
            )#column
        )#fluidRow
    }
    return(myrow)
})
output$discretecolorsfill=renderUI({
  info=rbind(rproperties(1),
             rproperties(2),
             rproperties(3))
  scalable=length(which(info$types=="map" & info$properties=="fill"))
  myrow=HTML("This is useful only if the 'fill' property of at least one geom is mapped to a variable, which is not the case here.")
  if(scalable>0){
  myrow=fluidRow(
        column(width=3,
               radioButtons("discrete_colorscale_fill", 
                            "discrete_colorscale_fill",
                            choices=c("",
                                      "scale_fill_brewer"),
                            selected="")
               
        ),
        column(width=3,
               conditionalPanel(
                 condition="input.discrete_colorscale_fill=='scale_fill_brewer'",
                 radioButtons(inputId="palette_fill",
                                       label="palette",
                                       choiceNames=lapply(mypalettes(),"f_palette_label"),
                                       choiceValues=mypalettes(),
                                       selected=paste0("<img src='palette_","Blues",".png'>")
                 )
               )#conditionalPanel
               
        )#column
      )#fluidRow
  }
  return(myrow)
})
output$discretecolorscolor=renderUI({
  info=rbind(rproperties(1),
             rproperties(2),
             rproperties(3))
  scalable=length(which(info$types=="map" & info$properties=="color"))
  myrow=fluidRow("This is useful only if the 'color' property of at least one geom is mapped to a variable, which is not the case here.")
  if(scalable>0){
  myrow=fluidRow(
    column(width=3,
           radioButtons("discrete_colorscale_color", "discrete_colorscale_color",
                        choices=c("",
                                  "scale_color_brewer"),
                        selected="")
           
    ),
    column(width=3,
           conditionalPanel(
             condition="input.discrete_colorscale_color=='scale_color_brewer'",
             radioButtons(inputId="palette_color",
                          label="palette",
                          choiceNames=lapply(mypalettes(),"f_palette_label"),
                          choiceValues=mypalettes(),
                          selected=paste0("<img src='palette_","Blues",".png'>")
             )
           )#conditionalPanel
           
    )#column
  )#fluidRow
  }
  return(myrow)
})

output$xaxis=renderUI({
  combi=fcombi()
  myrow=fluidRow(br(),
                 "The horizontal axis cannot be adjusted because x is not quantitative",
                 br(),br()
                 )
  if(combi %in% c("numericnone","numericnumeric")){
      myrow=fluidRow(
        column(width=3,
               selectInput(inputId="xtrans",
                           label="x axis transform",
                           choices=c("no transform","log","exp"),
                           selected="no transform")
        ),
        column(width=3,
               textInput(inputId= "xmin",
                         label="xmin (truncates to values > xmin)",
                         value=c(""))
        ),
        column(width=3,
               textInput(inputId= "xmax",
                         label="xmax (truncates to values < xmax)",
                         value=c(""))
        ),
        column(width=3,
               selectInput(inputId= "xaxlabels",
                           label="x axis labels",
                           choices=c("none","percent"),
                           selected=c("none")
               )
        )
      )#fluidRow
    }
    return(myrow)
})

output$yaxis=renderUI({
  combi=fcombi()
  myrow=fluidRow(br(),
                 "The vertical axis cannot be adjusted because y is not quantitative",
                 br(),br()
                 )
  if(combi %in% c("factornone","numericnone","factornumeric","numericnumeric")){
    myrow=fluidRow(
      column(width=3,
             selectInput(inputId="ytrans",
                         label="y axis transform",
                         choices=c("no transform","log","exp"),
                         selected="no transform")
      ),
      column(width=3,
             textInput(inputId= "ymin",
                       label="ymin (truncates to values > ymin)",
                       value=c(""))
      ),
      column(width=3,
             textInput(inputId= "ymax",
                       label="ymax (truncates to values < ymax)",
                       value=c(""))
      ),
      column(width=3,
             selectInput(inputId= "yaxlabels",
                         label="y axis labels",
                         choices=c("none","percent"),
                         selected=c("none")
             )
      )
    )#fluidRow
  }
  return(myrow)
})


observe({
  data=fdata_s()
  datatypes=fdatatypes()
  ind=which(datatypes=="factor")
  cat_variables=c("none",colnames(data)[ind])
  updateSelectInput(session, "xfacet",
                    choices  = cat_variables,
                    selected= "none")
  updateSelectInput(session, "yfacet",
                    choices  = cat_variables,
                    selected= "none")
})
