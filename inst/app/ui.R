shinyUI(fluidPage(
  tabsetPanel(id="general",
    source(findmypath("app/scripts", "ui_presentation.R"))$value,
    source(findmypath("app/scripts", "ui_data.R"))$value,
    source(findmypath("app/scripts", "ui_plot_general.R"))$value,
    source(findmypath("app/scripts", "ui_export.R"))$value,
    source(findmypath("app/scripts", "ui_script.R"))$value
  )#tabsetPanel
))