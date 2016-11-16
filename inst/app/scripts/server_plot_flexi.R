rproperties=function(layer){
  dat=properties_geoms()
  dat$name_type_inputs=paste0("type",dat$properties,layer)
  dat$name_prop_inputs=paste0(dat$name_prop_inputs,layer)
  for(i in 1:length(dat$properties)){
    if(dat$name_type_inputs[i] %in% names(input)){
       dat$types[i]=input[[dat$name_type_inputs[i]]]
       dat$name_prop_inputs[i]=paste0(dat$types[i],dat$properties[i],layer)
    }
    if(dat$name_prop_inputs[i] %in% names(input)){
       x=input[[dat$name_prop_inputs[i]]]
       x=striptovalue(x)
       dat$values[i]=x
    }  
  }
  dat$quotes[which(dat$types=="map")]=FALSE
  return(dat)
}

toscript=function(string,myscript){
  string=paste0("<p>",string,"</p>")
  cat(string,file=myscript)
}

fsummaries=function(){
  summaries=c("..density..","..level..","..count..","..sum..")
}

properties_geoms=function(){  
  dat=read.csv(findmypath("app/data", "properties_geoms.csv"),
               sep=";",
               stringsAsFactors =FALSE,
               na.strings="NA")
  return(dat)
}

info_geoms=function(){  
  dat=read.csv(findmypath("app/data", "info_geoms.csv"),
               sep=";",
               stringsAsFactors =FALSE)
  return(dat)
}

###############################################################
create_ggdata=function(){
  ## variables of dataset are not all included by default to avoid removing lines with NAs
  data=fdata_s()
  xy=c(input$varx,input$vary)
  xy=xy[which(xy!="none")]
  ggdata=data[xy]
  ## mapped variables should appear in ggdata
  info=rbind(rproperties(1),
             rproperties(2),
             rproperties(3))
  index_mapped_variables=which(info$types=="map" &
                               info$properties!="y" &
                               !(info$values%in%fsummaries())&
                               !(info$properties%in%colnames(ggdata))
                               )
  ggdata=data.frame(ggdata,data[as.vector(info$values[index_mapped_variables])])
  ## variables defining facets should appear in ggdata
  if(input$xfacet!="none" & !(input$xfacet%in% colnames(ggdata))){
    ggdata=data.frame(ggdata,data[input$xfacet])
    }
  if(input$yfacet!="none" & !(input$yfacet%in% colnames(ggdata))){
    ggdata=data.frame(ggdata,data[input$yfacet])
    }
  ggdata=na.omit(ggdata)
}

write_ggdata=function(ggdata){
  lines=c("### GGDATA : (consider variables used by graphic only)")
  line="ggdata=data.frame("
  for (i in 1:ncol(ggdata)){
    line=paste0(line,colnames(ggdata)[i])
    if(i<ncol(ggdata)){line=paste0(line,",")}
  }
  line=paste0(line,")")
  lines=c(lines,line)
  lines=c(lines,"ggdata=na.omit(ggdata)")
  return(lines)
}
######################################
create_ggplot=function(ggdata){
    p=ggplot(data=ggdata)
    if(input$varx!="none" & input$vary=="none"){
      p=p+aes_string(x=input$varx)
    }
    if(input$varx!="none" & input$vary!="none"){
      p=p+aes_string(x=input$varx,y=input$vary)
    }
    return(p)
}

write_ggplot=function(){
  lines=c("### GGPLOT CREATION:")
  line="p=ggplot(data=ggdata,aes(x="
  if(input$varx!="none"){
    line=paste0(line,input$varx)
  }
  if(input$vary!="none"){
    line=paste0(line,",y=",input$vary)
  }
  line=paste0(line,"))")
  lines=c(lines,line)
  if(length(lines)==1){lines=c()}
  return(lines)
}
#################################################
write_labels=function(){
  lines="### LABELS: "
  if(input$xlab!=""){
    line=paste0("p=p+xlab('",input$xlab,"')")
    lines=c(lines,line)
  }
  if(input$ylab!=""){
    line=paste0("p=p+ylab('",input$ylab,"')")
    lines=c(lines,line)
  }
  if(input$title!=""){
    line=paste0("p=p+ggtitle('",input$title,"')")
    lines=c(lines,line)
  }
  if(length(lines)==1){lines=c()}
  return(lines)
}

write_axes_trans=function(){
  lines=c("## Axes: transformations")
  if("xtrans" %in% names(input)){
      if(input$xtrans!="no transform"){
        line=paste0("p=p+coord_trans(x='",input$xtrans,"')")
        lines=c(lines,line)  
      }
      if(input$xaxlabels!="none"){
        line=paste0("p=p+scale_x_continuous(labels=scales::percent)")
        lines=c(lines,line)
      }
  }
  if("ytrans" %in% names(input)){
      if(input$ytrans!="no transform"){
        line=paste0("p=p+coord_trans(y='",input$ytrans,"')")
        lines=c(lines,line)
      }
      if(input$yaxlabels!="none"){
        line=paste0("p=p+scale_y_continuous(labels=scales::percent)")
        lines=c(lines,line)
      }
  }
  if(length(lines)==1){lines=c()}
  return(lines)
}
write_axes_lims=function(ggdata){
  lines=c("##Axes: limits")
  combi=fcombi()
  if(combi %in% c("numericnone","numericnumeric")){
    if("xmin" %in% names(input)){
        if(input$xmin!=""){xmin=input$xmin}else{xmin=NA}
        if(input$xmax!=""){xmax=input$xmax}else{xmax=NA}
        if(input$xmin!=""|input$xmax!=""){
          line=paste0("p=p+scale_x_continuous(limits=c(",xmin,",",xmax,"))")
          lines=c(lines,line)
        }
    }
  }
  if(combi %in% c("factornone","numericnone","factornumeric","numericnumeric")){
    if("ymin" %in% names(input)){
        if(input$ymin!=""){ymin=input$ymin}else{ymin=NA}
        if(input$ymax!=""){ymax=input$ymax}else{ymax=NA}
        if(input$ymin!=""|input$ymax!=""){
          line=paste0("p=p+scale_y_continuous(limits=c(",ymin,",",ymax,"))")
          lines=c(lines,line)
        }
    }
  }
  if(length(lines)==1){lines=c()}
  return(lines)
}

write_facets=function(){
  lines=c("## Facets:")
  if(input$yfacet!="none" & input$xfacet=="none"){
    line=paste0("p=p+facet_grid(",input$yfacet,"~.",")")
    lines=c(lines,line)
  }
  if(input$xfacet!="none" & input$yfacet=="none"){
    lines=paste0("p=p+facet_grid(.~",input$xfacet,")")
    lines=c(lines,line)
  }
  if(input$xfacet!="none" & input$yfacet!="none"){
    line=paste0("p=p+facet_grid(",input$yfacet,"~",input$xfacet,")")
    lines=c(lines,line)
  }
  if(length(lines)==1){lines=c()}
  return(lines)
}

write_colorscale=function(){
  lines=c("## Color scale:")
  if("continuous_colorscale" %in% names(input)){
      if(input$continuous_colorscale=="scale_fill_gradient"){
        line=paste0("p=p+scale_fill_gradient(low='",striptovalue(input$low),
                    "', high='",striptovalue(input$high),"')")
      }
      if(input$continuous_colorscale=="scale_fill_gradient2"){
        line=paste0("p=p+scale_fill_gradient2(low='",
                    striptovalue(input$low2),
                    "', mid='",striptovalue(input$mid),
                    "', high='",striptovalue(input$high2),"')")
      }
      if(input$continuous_colorscale=="scale_fill_gradientn"){
        line=paste0("p=p+scale_fill_gradientn(colors=",input$colors,"(",input$ncolors,"))")
        
      }
      lines=c(lines,line)
  }
  if("discrete_colorscale_fill" %in% names(input)){
    if(input$discrete_colorscale_fill=="scale_fill_brewer"){
      line=paste0("p=p+scale_fill_brewer(palette='",striptovalue(input$palette_fill),"')")
    }
    lines=c(lines,line)
  }
  if("discrete_colorscale_color" %in% names(input)){
    if(input$discrete_colorscale_color=="scale_fill_brewer"){
      line=paste0("p=p+scale_color_brewer(palette='",striptovalue(input$palette_color),"')")
    }
    lines=c(lines,line)
  }
  
  if(length(lines)==1){lines=c()}
  return(lines)
}

write_geom=function(layer){
  lines=paste0("### LAYER ",layer," :")
  rgeom=get(paste0("rgeom",layer))
  mygeom=rgeom()
  input$varx
  input$vary
  if(mygeom!="geom_none"){
        info=rproperties(layer)
        ind_set=which(info$types=="set" & 
                      properties_geoms()[[mygeom]]>0 &
                      info$values!=info$defaults)
        ind_map=which(info$types=="map" & 
                      properties_geoms()[[mygeom]]>0 &
                      info$values!=info$defaults)
        line=paste0("p=p+",mygeom,"(")
        if(length(info$values[ind_map])>0){
          line=paste0(line,"mapping=aes(")
          for (k in 1:length(ind_map)){
            line=paste0(line,info$properties[ind_map][k],"=")
            if(info$quotes[ind_map][k]){line=paste0(line,"'")}
            line=paste0(line,info$values[ind_map][k])
            if(info$quotes[ind_map][k]){line=paste0(line,"'")}
            if(k<length(ind_map)){line=paste0(line,",")}
          }
          line=paste0(line,")")
        }
        if(length(ind_set)>0){
          if(length(ind_map)>0){line=paste0(line,",")}
          for(k in 1:length(ind_set)){
            line=paste0(line,info$properties[ind_set][k],"=")
            if(info$quotes[ind_set][k]){line=paste0(line,"'")}
            line=paste0(line,info$values[ind_set][[k]])
            if(info$quotes[ind_set][k]){line=paste0(line,"'")}
            if(k<length(ind_set)){line=paste0(line,",")}
          }
        }
        line=paste0(line,")")
        lines=c(lines,line)
  }
  if(length(lines)==1){lines=c()}
  return(lines)
}

write_theme=function(){
  lines=c("### theme:")
  if(input$theme!="grey"){
    line=paste0("p=p+theme_",input$theme,"()")
    lines=c(lines,line)
  }
  if(length(lines)==1){lines=c()}
  return(lines)
}

write_plot=function(){
  lines=c("### PLOT",
          "plot(p)")
}

############################
eval_all=function(command_lines,envir){
  if(length(command_lines)>0){
    for (i in 1:length(command_lines)){
      eval(parse(text=command_lines[i]),env=envir)
    }
  }
}
###################################

plot_flexi=function(){
  ggdata=create_ggdata()
  ####### GGDATA AND GGPLOT
  command_lines_ggdata=write_ggdata(ggdata)
  command_lines_ggplot=write_ggplot()
  eval_all(command_lines_ggplot,envir=environment())
  ###### GEOMS
  command_lines_layer1=write_geom(1)
  command_lines_layer2=write_geom(2)
  command_lines_layer3=write_geom(3)
  ##### LABELS 
  command_lines_labels=write_labels()
  ##### AXES TRANSFORMATIONS
  command_lines_axes_trans=write_axes_trans()
  ##### AXES LIMITS
  command_lines_axes_lims=write_axes_lims(ggdata)
  #### FACETING 
  command_lines_facets=write_facets()
  #### THEME
  command_lines_theme=write_theme()
  #### COLOR SCALE
  command_lines_colorscale=write_colorscale()
  #### PLOT
  command_lines_plot=write_plot()
  #####################################
  lines=c(command_lines_ggplot,
          command_lines_layer1,
          command_lines_layer2,
          command_lines_layer3,
          command_lines_labels,
          command_lines_axes_trans,
          command_lines_axes_lims, 
          command_lines_facets,
          command_lines_theme,
          command_lines_colorscale,
          command_lines_plot)
  eval_all(lines,envir=environment())
  all_lines=c(command_lines_ggdata,lines)
  return(all_lines)
}

plot_layer=function(layer){
  ggdata=create_ggdata()
  ####### GGDATA AND GGPLOT
  command_lines_ggdata=write_ggdata(ggdata)
  command_lines_ggplot=write_ggplot()
  eval_all(command_lines_ggplot,envir=environment())
  ###### GEOMS
  command_lines_layer=write_geom(layer)
  ##### LABELS 
  command_lines_labels=write_labels()
  ##### AXES TRANSFORMATIONS
  command_lines_axes_trans=write_axes_trans()
  ##### AXES LIMITS
  command_lines_axes_lims=write_axes_lims(ggdata)
  #### FACETING 
  command_lines_facets=write_facets()
  #### THEME
  command_lines_theme=write_theme()
  #### COLOR SCALE
  command_lines_colorscale=write_colorscale()
  #### PLOT
  command_lines_plot=write_plot()
  #####################################
  lines=c(command_lines_ggplot,
          command_lines_layer,
          command_lines_labels,
          command_lines_axes_trans,
          command_lines_axes_lims, 
          command_lines_facets,
          command_lines_theme,
          command_lines_colorscale,
          command_lines_plot)
  eval_all(lines,envir=environment())
}

