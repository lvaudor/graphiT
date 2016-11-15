fdata=reactive({
  if(!is.null(input$file)){
    datapath=gsub(pattern="\\\\",x=input$file$datapath,replacement="/")
    line=paste0("read.csv('",
                datapath,
                "',header=",input$header,
                ",sep='",input$sep,
                "',dec='",input$dec,
                "',na.strings='",input$na.strings,
                "')")
  }
  if(is.null(input$file)){
    data=read.csv(findmypath("app/data", "catdata.csv"), sep=";")
    line="read.csv(findmypath('app/data','catdata.csv'),sep=';')"
  }
  data=eval(parse(text=line))
  return(data)
})


fdatatypes=reactive({
  data=fdata()
  datatypes=rep(NA,ncol(data))
  for (i in 1:ncol(data)){
    type=class(data[,i])
    if(type=="integer"){type="numeric"}
    datatypes[i]=type
  }
  return(datatypes)
})
fsubsetvar=reactive({
  return(input$subsetvar)
})
fsubsetlev=reactive({
  return(input$subsetlev)
})
#################################################
fdata_s=reactive({
  data=fdata()
  gsubsetvar=input$subsetvar
  gsubsetlev=input$subsetlev
  ## subset
  ind=1:nrow(data)
  if(gsubsetvar!="none" & gsubsetlev!=""){
    ind=which(data[[gsubsetvar]]==gsubsetlev)
  }
  dat=as.data.frame(data[ind,1:ncol(data)])
  colnames(dat)=colnames(data)
  data=dat
  return(data)
})
output$dataTable=renderTable({
  data=fdata_s()
  return(data)
})
#########################################
# varx=reactive({
#   var=fdata_s()[[input$varx]]
#   return(var)
# })
########
# vary=reactive({
#   var=fdata_s()[[input$vary]]
#   return(var)
# })
