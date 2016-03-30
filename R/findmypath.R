#' Find path to graphiT package
#'
#' This function is used internally to find package's path.
#' @keywords graphiT, graphic, toolkat
#' @export

findmypath=function(dir,file){
  path=system.file(dir,file,package="graphiT")
  return(path)
}
