allcolors=mycolors()

for (i in 1:length(allcolors)){
  #allcolors=mycolors()
  png(paste0("www/color_",allcolors[i],".png"),width=15, height=15)
  par(mar=c(0,0,0,0))
  plot(c(0,1),c(0,1))
  polygon(c(0,1,1,0),c(0,0,1,1), col=allcolors[i])
  dev.off()
}



allshapes=c(1:25)
require(ggplot2)
for (i in 1:length(allshapes)){

  png(paste0("www/shape_",allshapes[i],".png"),width=30, height=30)
  par(mar=c(0,0,0,0))
  dat=data.frame(x=0,y=0)
  p=ggplot(data=dat, aes(x=x,y=y))
  p=p+geom_point(shape=allshapes[i],size=5)
  p=p+scale_x_continuous(limits=c(-0.5,0.5))+scale_y_continuous(limits=c(-0.5,0.5))
  p=p + theme(axis.line=element_blank(),axis.text.x=element_blank(),
            axis.text.y=element_blank(),axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),legend.position="none",
            panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),plot.background=element_blank())
  plot(p)
  dev.off()
}

allpalettes=mypalettes()
require(ggplot2)
for (i in 1:length(allpalettes)){
  png(paste0("www/palette_",allpalettes[i],".png"),width=60, height=20)
  par(mar=c(0,0,0,0))
  display.brewer.pal(7,allpalettes[i])
  dev.off()
}


alllinetypes=1:5
require(ggplot2)
for (i in 1:length(alllinetypes)){
  png(paste0("www/linetype_",alllinetypes[i],".png"),
      width=60, height=20)
  par(mar=c(0,0,0,0))
  dat=data.frame(x=c(-10,10),y=c(0,0))
  p=ggplot(data=dat, aes(x=x,y=y))
  p=p+geom_path(linetype=alllinetypes[i],size=1)
  p=p+scale_x_continuous(limits=c(-10,10))+scale_y_continuous(limits=c(-0.5,0.5))
  p=p + theme(axis.line=element_blank(),axis.text.x=element_blank(),
              axis.text.y=element_blank(),axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),legend.position="none",
              panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),plot.background=element_blank())
  plot(p)
  dev.off()
}


allsizes=1:5
require(ggplot2)
for (i in 1:length(allsizes)){
  png(paste0("www/linetype_",allsizes[i],".png"),
      width=30, height=30)
  par(mar=c(0,0,0,0))
  dat=data.frame(x=c(0),y=c(0))
  p=ggplot(data=dat, aes(x=x,y=y))
  p=p+geom_point(size=allsizes[i],size=1)
  p=p+scale_x_continuous(limits=c(-0.5,0.5))+scale_y_continuous(limits=c(-0.5,0.5))
  p=p + theme(axis.line=element_blank(),axis.text.x=element_blank(),
              axis.text.y=element_blank(),axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),legend.position="none",
              panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),plot.background=element_blank())
  plot(p)
  dev.off()
}

