#' Launch the Graphic ToolKat
#'
#' This function allows you to launch the Graphic ToolKat interface. This is a Shiny App designed to help users produce graphics.
#' For more information see package's vignette.
#' @keywords graphiT, graphic, toolkat
#' @export
#' @examples
#' graphiT()

graphiT=function(){
  shiny::runApp(findmypath("app",""))
}

