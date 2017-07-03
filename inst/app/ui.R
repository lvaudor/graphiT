shinyUI(fluidPage(
  tabsetPanel(id="general",
    source(findmypath("scripts", "ui_presentation.R"))$value,
    source(findmypath("scripts", "ui_data.R"))$value,
    source(findmypath("scripts", "ui_plot_general.R"))$value,
    source(findmypath("scripts", "ui_export.R"))$value,
    source(findmypath("scripts", "ui_script.R"))$value
  )#tabsetPanelc
))