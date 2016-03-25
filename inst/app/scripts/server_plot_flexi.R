rsymbolism=reactive({
  v_inputs=reactiveValuesToList(input)
  elems=c("color","size","fill","shape","linetype")
  ##
  typeelems=paste0("type",elems)
  types=c()
  for(i in 1:length(elems)){
    types=c(types,v_inputs[[typeelems[i]]])
  }  #type:a length 5 vector with value "set" or "map"
  ##
  symbols=c()
  for (i in 1:length(elems)){
    symbols=c(symbols,v_inputs[[paste0(types[i],elems[i])]])
  } #symbols: a length 5 vector with values corresponding to set or map parameters (variable names)
  return(list(elems=elems,
              types=types,
              symbols=symbols))
})

plot_flexi=function(){
  ## DATA, X, Y
  data=fdata_s()
  x=varx()
  y=vary()
  ggdata=data.frame(x=x)
  if(input$vary!="none"){ggdata=data.frame(x=x,y=y)}

  ### SET SYMBOLS OR MAP TO VARIABLES ###
  info=rsymbolism()
  ind_map=which(info$types=="map")
  list_map=as.list(info$symbols[ind_map])
  names(list_map)=info$elems[ind_map]
  ind_set=which(info$types=="set")
  list_set=as.list(info$symbols[ind_set])
  names(list_set)=info$elems[ind_set]
  ind=which(names(list_set) %in% c("size","shape","linetype"))
  list_set[ind]=as.numeric(list_set[ind])
  ### GET SYMBOLISM ACCORDING TO GEOM ###
  geoms=rgeoms()
  geom_symbolism= list("geom_bar"=c("color","fill","linetype"),
                       "geom_bin2d"=c("color","fill","linetype"),
                       "geom_boxplot"=c("color","fill","linetype"),
                       "geom_density"=c("color","fill","linetype"),
                       "geom_density2d"=c("color","linetype"),
                       "geom_dotplot"=c("color","fill"),
                       "geom_freqpoly"=c("color","fill","linetype"),
                       "geom_hex"=c("color","fill"),
                       "geom_histogram"=c("color","fill","linetype"),
                       "geom_jitter"=c("color","size","fill","shape"),
                       "geom_point"=c("color","size","fill","shape"),
                       "geom_quantile"=c("color","fill","linetype"),
                       "geom_rug"=c("color","size","linetype"),
                       "geom_smooth"=c("color","fill","linetype"),
                       "geom_violin"=c("color","fill","linetype"))

  if(length(list_map)>0){
    for(i in 1:length(list_map)){
      namevar=list_map[[i]]
      var=data[[namevar]]
      ggdata=data.frame(ggdata,var)
      colnames(ggdata)[ncol(ggdata)]=namevar
    }
  }
  if(input$xfacet!="none"){
    ggdata=data.frame(ggdata,
                      data[,which(colnames(data)==input$xfacet)])
    colnames(ggdata)[length(colnames(ggdata))]=input$xfacet
    }
  if(input$yfacet!="none"){
    ggdata=data.frame(ggdata,
                      data[,which(colnames(data)==input$yfacet)])
    colnames(ggdata)[length(colnames(ggdata))]=input$yfacet
  }
  ggdata=na.omit(ggdata)
  ##################################
  p=ggplot(data=ggdata)
  ##################################
  if(input$varx!="none" & input$vary=="none"){
    p=p+aes(x=x)
  }
  if(input$varx!="none" & input$vary!="none"){
    p=p+aes(x=x,y=y)
  }
  ##### MAPPING TO VARIABLES #########
  a=do.call(what="aes_string",args=list_map)
  p=p+a
  ##### LABELS #######################
  p=p+xlab(input$xlab)
  p=p+ylab(input$ylab)
  p=p+ggtitle(input$title)
  ##### AXES TRANSFORMATIONS #########
  if(input$xtrans!="no transform"){
    p=p+coord_trans(xtrans=input$xtrans)
  }
  if(input$ytrans!="no transform"){
    p=p+coord_trans(ytrans=input$ytrans)
  }
  ##### AXES LIMITS ##################
  lims=as.numeric(c(input$xmin,input$xmax,input$ymin,input$ymax))
  ind=which(is.na(lims))
  if(length(ind)!=4){
    lims[ind]=c(min(x,na.rm=T),max(x,na.rm=T),min(y,na.rm=T),max(y,na.rm=T))[ind]
    p=p+xlim(c(as.numeric(input$xmin),as.numeric(input$xmax)))
    p=p+ylim(c(as.numeric(input$ymin),as.numeric(input$ymax)))
  }
  ###### MULTIPLE PLOTS (FACETS) #####
  if(input$xfacet!="none" & input$yfacet=="none"){p=p+facet_grid(paste0(input$xfacet,"~."))}
  if(input$yfacet!="none" & input$xfacet=="none"){p=p+facet_grid(paste0(".~",input$yfacet))}
  if(input$xfacet!="none" & input$yfacet!="none"){p=p+facet_grid(paste0(input$xfacet,"~",input$yfacet))}
  ###### GEOMS #######################
  if(length(geoms)>0){
  if(geoms[1]!="geom_blank"){
  for(i in 1:length(geoms)){
      list_set_partial=list_set[1]
      list_set_partial=list_set[geom_symbolism[[geoms[i]]]]
      list_set_partial=list_set_partial[which(list_set_partial!="none")]
      l=do.call(what=geoms[i],args=list_set_partial)
      p=p+l
  }
  }
  }
  ###### STATS #######################
#   if(input$stat){
#     s=stat_smooth(geom="smooth",
#                   method=input$smooth_method,
#                   formula=as.formula(input$smooth_formula),
#                   fullrange=input$smooth_fullrange,
#                   level=input$smooth_level)
#     p=p+s
#   }
  ####################################
  f=get(paste0("theme_",input$theme))
  p=p+f()
  ####################################
  plot(p)

}
