tabPanel(title=h2(strong("2) Plot")),
         fluidRow(
           column(width=3,
                  h3(strong("a) Select variables"))),
           column(width=1,
                  br(),
                  actionButton(inputId="infoXY",
                               label=imageOutput("catpaw4",height="100%", width="100%"))
           ),
           column(width=2,
                  selectInput(inputId="varx",
                              label="X",
                              choices=c("none"),
                              selected="none")
           ),
           column(width=2,
                  selectInput(inputId="vary",
                              label="Y",
                              choices=c("none"),
                              selected="none")
           )
         ),#fluidRow
         uiOutput("infoXY"),
         fluidRow(
           column(width=3,
                  h3(strong("b) Select graphic type"))),
           column(width=1,
                  actionButton(inputId="infoGraphtype",
                               label=imageOutput("catpaw5",height="100%", width="100%"))
                  ),
           uiOutput("geom_type")
         ),#fluidRow
         uiOutput("infoGraphtype"),
         br(),
         fluidRow(
           column(width=4,
                  h3(strong("c) Adjust characteristics")),
                  tabsetPanel(
                    tabPanel(
                      h4("Symbols"),
                      navlistPanel(
                        tabPanel(imageOutput("catpaw6",height="100%", width="100%"),
                                 br(),
                                 includeHTML(findmypath("scripts","infoSymbols.html"))
                                 ),
                        tabPanel(
                          "Color",
                          radioButtons(inputId="typecolor",
                                       label="Type",
                                       choices=c("set","map"),
                                       selected="set"),
                          conditionalPanel(
                            condition="input.typecolor=='map'",
                            selectInput(inputId="mapcolor",
                                        label="Map color to",
                                        choices=c("none"),
                                        selected="none")
                          ),
                          conditionalPanel(
                            condition="input.typecolor=='set'",
                            selectInput(inputId="setcolor",
                                        label="Set color to",
                                        choices=c("black","white","red","blue","green","orange"),
                                        selected="black")
                          )
                        ),
                        tabPanel(
                          "Size",
                          radioButtons(inputId="typesize",
                                       label="Type",
                                       choices=c("set","map"),
                                       selected="set"),
                          conditionalPanel(
                            condition="input.typesize=='map'",
                            selectInput(inputId="mapsize",
                                        label="Map size to",
                                        choices=c("none"),
                                        selected="none")
                          ),
                          conditionalPanel(
                            condition="input.typesize=='set'",
                            selectInput(inputId="setsize",
                                        label="Set size to",
                                        choices=c(1:5),
                                        selected=1)
                          )
                        ),
                        tabPanel(
                          "Shape",
                          radioButtons(inputId="typeshape",
                                       label="Type",
                                       choices=c("set","map"),
                                       selected="set"),
                          conditionalPanel(
                            condition="input.typeshape=='map'",
                            selectInput(inputId="mapshape",
                                        label="Map shape to",
                                        choices=c("none"),
                                        selected="none")
                          ),
                          conditionalPanel(
                            condition="input.typeshape=='set'",
                            selectInput(inputId="setshape",
                                        label="Set shape to",
                                        choices=c(0:25,"*","."),
                                        selected="1"),
                            imageOutput("symbol_shapes")
                          )
                        ),
                        tabPanel(
                          "Fill",
                          radioButtons(inputId="typefill",
                                       label="Type",
                                       choices=c("set","map"),
                                       selected="set"),
                          conditionalPanel(
                            condition="input.typefill=='map'",
                            selectInput(inputId="mapfill",
                                        label="Map fill to",
                                        choices=c("none"),
                                        selected="none")
                          ),
                          conditionalPanel(
                            condition="input.typefill=='set'",
                            selectInput(inputId="setfill",
                                        label="Set fill to",
                                        choices=c("none","black","white","red","green","yellow","blue"),
                                        selected="none")
                          )
                        ),
                        tabPanel(
                          "Line type",
                          radioButtons(inputId="typelinetype",
                                       label="Type",
                                       choices=c("set","map"),
                                       selected="set"),
                          conditionalPanel(
                            condition="input.typelinetype=='map'",
                            selectInput(inputId="maplinetype",
                                        label="Map linetype to",
                                        choices=c("none"),
                                        selected="none")
                          ),
                          conditionalPanel(
                            condition="input.typelinetype=='set'",
                            selectInput(inputId="setlinetype",
                                        label="Set linetype to",
                                        choices=c(1:5),
                                        selected=1)
                          )
                        )
                      )#navlistPanel
                    ),#tabPanel

                    tabPanel(
                      h4("Features"),
                      navlistPanel(tabPanel(imageOutput("catpaw7",height="100%", width="100%"),
                                            br(),
                                            includeHTML(findmypath("scripts","infoFeatures.html"))
                                            ),
                                   tabPanel(
                                     "Size",
                                     sliderInput(inputId="height",
                                                 label="height",
                                                 min=200,step=100,
                                                 max=1200,value=500),
                                     sliderInput(inputId="width",
                                                 label="width",
                                                 min=200,step=100,
                                                 max=1600,value=800)
                                   ),#tabPanel
                                   tabPanel(
                                     "Axes",
                                     selectInput(inputId="xtrans",
                                                 label="x axis transform",
                                                 choices=c("no transform","log","exp","logp1"),
                                                 selected="no transform"),
                                     selectInput(inputId="ytrans",
                                                 label="y axis transform",
                                                 choices=c("no transform","log","exp","logp1"),
                                                 selected="no transform"),
                                     fluidRow(
                                       column(width=6,
                                              textInput(inputId= "xmin",
                                                        label="xmin",
                                                        value=c(""))
                                       ),
                                       column(width=6,
                                              textInput(inputId= "xmax",
                                                        label="xmax",
                                                        value=c(""))
                                       )
                                     ),
                                     fluidRow(
                                       column(width=6,
                                              textInput(inputId= "ymin",
                                                        label="ymin",
                                                        value=c(""))
                                       ),
                                       column(width=6,
                                              textInput(inputId= "ymax",
                                                        label="ymax",
                                                        value=c(""))
                                       )
                                     )
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
                                     textInput("xlab","x label",
                                               value=""),
                                     textInput("ylab","y label",
                                               value=""),
                                     textInput("title", "title",
                                               value="")
                                   ),#tabPanel
                                   tabPanel(
                                     "Themes",
                                     radioButtons("theme", "theme",
                                                  choices=c("grey","bw","classic","minimal"),
                                                  selected="grey")
                                   )#tabPanel
                      )# navlistPanel
                    )#,#tabPanel
#                     tabPanel(
#                       "Stats",
#                       checkboxInput("stat","Smooth",value=FALSE),
#                       selectInput("smooth_method","method",
#                                   choices=c("auto","loess","gam","lm","glm","rlm"),
#                                   selected="auto"),
#                       textInput("smooth_formula","formula",
#                                 value="y~x"),
#                       checkboxInput("smooth_fullrange","full range", value=FALSE),
#                       sliderInput("smooth_level","level",min=0,max=1,step=0.05,value=0.95)
#                     )#tabPanel
                  )#navlistPanel
           ),#column
           column(width=8,align="center",
                  br(),br(),br(),br(),
                  wellPanel(
                    br(),plotOutput("plot",height="100%", width="100%")
                  )
           ) #column
         )# fluidRow
)