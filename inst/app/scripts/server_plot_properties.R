anywidget=function(widget,
                   inputId,
                   label,
                   value,
                   choices,
                   selected,
                   min,
                   max,
                   step){
  if(widget=="radioButtons"){
    mywidget=radioButtons_withHTML(inputId=inputId,
                                   label=label,
                                   choices=choices,
                                   selected=selected)
  }
  if(widget=="textInput"){
    mywidget=textInput(inputId=inputId,
                       label=label,
                       value="")
  }
  if(widget=="sliderInput"){
    mywidget=sliderInput(inputId=inputId,
                         label=label,
                         min=min,
                         max=max,
                         step=step,
                         value=value)
  }
  return(mywidget)
}

panel_UI_build=function(panel,
                        properties,
                        nameinputs,
                        mappables,
                        layer,
                        widgets,
                        list_choices,
                        value="",
                        comments=rep("",length(properties)),
                        min,
                        max,
                        step){
  for (i in 1:length(properties)){
    property=properties[i]
    nameinput=nameinputs[i]
    mappable=mappables[i]
    widget=widgets[i]
    comment=comments[i]
      if(mappable){
            choices=list_choices[[nameinput]]
            mypanel=wellPanel(
                     HTML(paste0("<h3>",property,"</h3>")),
                     HTML(comment),
                     radioButtons(inputId=paste0("type",nameinput,layer),
                                  label="Type",
                                  choices=c("set","map"),
                                  selected="set"),
                     conditionalPanel(
                       condition=paste0("input.type",nameinput,layer,"=='map'"),
                       selectInput(inputId=paste0("map",nameinput,layer),
                                   label=paste0("Map ",property," to"),
                                   choices=c("none"),
                                   selected="none")
                     ),
                     conditionalPanel(
                       condition=paste0("input.type",nameinput,layer,"=='set'"),
                       anywidget(widget=widget,
                                 inputId=paste0("set",nameinput,layer),
                                 label=paste0("Set ",property," to"),
                                 choices=choices,
                                 selected=choices[1],
                                 value=1)
                     )
                )
      }
      if(!mappable){
          mypanel=wellPanel(anywidget(widget=widget,
                                      inputId=paste0(nameinput,layer),
                                      label=property,
                                      choices=list_choices[[nameinput]],
                                      selected=list_choices[[nameinput]][1],
                                      value=1,
                                      min=0,
                                      max=1,
                                      step=0.1),
                            HTML(comment)
                           )
      }
    assign(paste0("wellPanel_",property),mypanel)
  }
  logopanel=HTML(paste0("<img src='prop_",
                        panel,
                        ".png'>")) 
  
  list_wellPanels=vector("list",length=length(properties)+1)
  list_wellPanels[[1]]=logopanel
  for(i in 1:length(properties)){
    list_wellPanels[[i+1]]=get(paste0("wellPanel_",properties[i]))
  }
  p=do.call(tabPanel,
            list_wellPanels)
}

allprop_UI_build=function(layer){
    data=properties_geoms()
    rgeom=get(paste0("rgeom",layer))
    mygeom=rgeom()
    if(mygeom!="geom_none"){
      ind=which(data[[mygeom]]>0)
      o=order(data[[mygeom]][ind])
      data=data[ind[o],]
      list_choices=list(
          color=c("default",paste0("<img src='color_",mycolors(),".png'>")),
          size=c("default",1:5),
          shape=c("default",paste0("<img src='shape_",0:25,".png'>")),
          fill=c("default",paste0("<img src='color_",mycolors(),".png'>")),
          linetype=c("default",paste0("<img src='linetype_",1:5,".png'>")),
          position=c("default","stack","dodge","fill"),
          show.legend=c("default","TRUE","FALSE"),
          y=c("default","(..count..)/sum(..count..)"),
          method=c("default","lm","auto","loess","glm"),
          drop=c("default","TRUE","FALSE"),
          notch=c("default","TRUE","FALSE"),
          varwidth=c("default","TRUE","FALSE"),
          bw=c("default","nrd0","sj"),
          kernel=c("default","gaussian","rectangular","triangular","epanechnikov","biweight","cosine","optcosine"),
          binaxis=c("default","x","y"),
          stackdir=c("default","up","down","center","centerwhole"),
          stackgroups=c("default","TRUE","FALSE"),
          closed=c("default","right","left"),
          stroke=c("default",1:5),
          sides=c("default",paste0("<img src='sides_",
                            c("t","b","r","l","tr","tl","br","bl","trbl"),
                            ".png'>")),
          se=c("default","TRUE","FALSE"),
          trim=c("default","TRUE","FALSE"),
          fun.data=c("default","mean_cl_boot","mean_cl_normal","mean_sdl","median_hilow"),
          fun.y=c("default","mean","min","max"),
          fun.ymin=c("default","min","mean"),
          fun.ymax=c("default","max","mean"),
          geom=c("default","point"),
          scale=c("default","area","count","width")
       )
       pinfo=tabPanel(imageOutput(paste0("catpawlayer",layer),height="100%", width="100%"),br(),
                      uiOutput(paste0("infoGeom",layer)))
       upanel=unique(data$panel)
       for (i in 1:length(upanel)){
           datatmp=data[which(data$panel==upanel[i]),]
           ppanel=panel_UI_build(panel=upanel[i],
                                 properties=datatmp$properties,
                                 nameinputs=datatmp$name_prop_inputs,
                                 mappables=datatmp$mappable,
                                 widgets=datatmp$widgets,
                                 comment=datatmp$comments,
                                 layer=layer,
                                 list_choices=list_choices)
           assign(paste0("p",upanel[i]),ppanel)
       }
       panels=c("pinfo",paste0("p",upanel))
  }
  if(mygeom=="geom_none"){
    pinfo=tabPanel("")
    pmessage=tabPanel(
      "No geom",
      "You have to choose a geom before setting its properties"
    )
    panels=c("pinfo","pmessage")
  }
  list_panels=vector("list",length=length(panels))
  for(i in 1:length(list_panels)){
    list_panels[[i]]=get(panels[i])
  }
  p=do.call(navlistPanel,
            list_panels)
}
############################################
output$prop1=renderUI({
  allprop_UI_build(layer=1)
})

output$prop2=renderUI({
  allprop_UI_build(layer=2)
})

output$prop3=renderUI({
  allprop_UI_build(layer=3)
})