findmypath=function(dir="",file=""){
  path=paste0("../",dir,"/",file)
  if(dir==""){path=file}
  if(file==""){path=dir}
  return(path)
}