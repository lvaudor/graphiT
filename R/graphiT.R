#' Launch the Graphic ToolKat
#'
#' This function allows you to launch the Graphic ToolKat. This is a Shiny App designed to help users produce ggplot graphics.
#' @keywords bwegek
#' @export
#' @examples
#' graphiT()

graphiT=function(){
  shiny::runApp(findmypath("app",""))
}

