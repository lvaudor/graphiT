output$plot=renderPlot({
      plot_flexi()
    },
    height=function(x){input$height},
    width=function(x){input$width}
)
output$plotexport=renderPlot({
  plot_flexi()
},
height=function(x){input$exportheight},
width=function(x){input$exportwidth}
)

############################################
############################################
geom_type_UI_build=function(w,geom_choices){
  input_names=paste0("geom_",geom_choices)
  logo_names=paste0("geom_",geom_choices)
  myvalues=rep(FALSE,length(geom_choices))
  myvalues[1]=TRUE
  for(i in 1:length(geom_choices)){
    w=paste0(w,
             column(width=1,
                    checkboxInput(inputId=input_names[i],
                                  label=geom_choices[i],
                                  value=myvalues[i]),
                    imageOutput(logo_names[i],width="100%", height="100%")
                    )
             )
  }
  return(w)
}

############################################
output$geom_type=renderUI({
  w=""
  geom_choices=fgeom_choices(fcombi())
  w=geom_type_UI_build(w,geom_choices)
  HTML(w)
})
fcombi=reactive({
  data=fdata_s()
  datatypes=fdatatypes()
  i1=which(colnames(data)==input$varx)
  i2=which(colnames(data)==input$vary)
  ###
  t1="none";if(length(i1)>0){t1=datatypes[i1]}
  t2="none";if(length(i2)>0){t2=datatypes[i2]}
  if(t1=="integer"){t1="numeric"}
  if(t2=="integer"){t2="numeric"}
  if(length(i1)==0 & length(i2)==0){combi="blank"}
  if(length(i1)>0|length(i2)>0){
    combi=paste0(t1,t2)
    if(combi=="factornumeric"){combi="numericfactor"}
    if(combi=="factornone"|combi=="nonefactor"){combi="factor"}
    if(combi=="numericnone"|combi=="nonenumeric"){combi="numeric"}
  }
  return(combi)
})


fgeom_choices=function(combi){
  if(combi=="blank"){
    choices="blank"
  }
  if(combi=="numeric"){
    choices=c(#"area",
      "histogram",
      "density",
      #"dotplot
      "freqpoly"
      )
  }
  if(combi =="factor"){
    choices=c("bar")
  }
  if(combi=="numericfactor"){
    choices =c(
      "boxplot",
      #"dotplot",
      "violin")
  }
  if(combi=="numericnumeric"){
    choices = c("point",
                "jitter",
                "rug",
                "bin2d",
                "density2d",
                "hex",
                "smooth"
    )

  }
  if(combi=="factorfactor"){
    choices=c("jitter",
              #"rug",
              "bin2d")
  }
  return(choices)
}

rgeoms=reactive({
  v_inputs=reactiveValuesToList(input)
  available_geoms=paste0("geom_",fgeom_choices(fcombi()))
  selection_geoms=which(unlist(v_inputs[available_geoms])==TRUE)
  selected_geoms=available_geoms[selection_geoms]
  return(selected_geoms)
})

################################################
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
