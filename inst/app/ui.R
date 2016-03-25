shinyUI(fluidPage(
  tabsetPanel(
    source(findmypath("app/scripts", "ui_presentation.R"))$value,
    source(findmypath("app/scripts", "ui_data.R"))$value,
    source(findmypath("app/scripts", "ui_plot.R"))$value,
    source(findmypath("app/scripts", "ui_export.R"))$value
  )#tabsetPane
))