tabsetPanel(
  tabPanel(
    imageOutput("catpaw7",height="100%", width="100%"),
    br(),
    includeHTML(findmypath("scripts","infoFeatures.html"))
),
tabPanel(
  "Size",
  fluidRow(
    column(width=4,
           sliderInput(inputId="height",
                       label="height",
                       min=200,step=100,
                       max=1200,value=500)
    ),
    column(width=4,
           sliderInput(inputId="width",
                       label="width",
                       min=200,step=100,
                       max=1600,value=800)
    )
  )#fluidRow Size
),#tabPanel
tabPanel(
  "Axes",
  uiOutput("xaxis"),
  uiOutput("yaxis")
),#tabPanel
tabPanel(
  "Facets",
  selectInput("xfacet", "x facet",
              choices=c("none"),
              selected="none"),
  selectInput("yfacet","y facet",
              choices=c("none"), 
              selected="none")
),#tabPanel
tabPanel(
  "Labels",
  fluidRow(
    column(width=4,
           textInput("title", "title",
                     value="")     
    ),
    column(width=4,
           textInput("xlab","x label",
                     value=""),
           textInput("ylab","y label",
                     value="")     
    )
  )
),#tabPanel
tabPanel(
  "Themes",
  radioButtons("theme", "theme",
               choices=c("grey","bw","classic","minimal"),
               selected="grey")
),#tabPanel
tabPanel("Colors",
         tabsetPanel(tabPanel("Scale for fill",   uiOutput("discretecolorsfill")),
                     tabPanel("Scale for color",  uiOutput("discretecolorscolor")),
                     tabPanel("Scale for geom_bin2d", uiOutput("continuouscolors"))
                     )
         )
)#tabsetPanel