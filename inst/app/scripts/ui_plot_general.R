tabPanel(title=h2(strong("2) Plot")),
         fluidRow(
           column(width=2,
                  tabsetPanel(
                    tabPanel(
                      "X and Y",
                      selectInput(inputId="varx",
                                  label="X",
                                  choices=c("none"),
                                  selected="none"),
                      selectInput(inputId="vary",
                                  label="Y",
                                  choices=c("none"),
                                  selected="none")
                    ),
                    tabPanel(
                      imageOutput("catpaw4",height="100%", width="100%"),
                      br(),
                      uiOutput("infoXY")
                    )
                  )
           ),
           column(width=10,
                  source(findmypath("app/scripts", "ui_plot_adjust_general.R"))$value
                  )
         ),#fluidRow
        fluidRow(
          column(width=4,
             tabsetPanel(
               tabPanel(
                 h4(strong("Layer 1")),
                 br(),
                 fluidRow(
                   column(width=3,
                          uiOutput("geom_layer1")
                   ),
                   column(width=9,
                          uiOutput("prop1")
                   )#column
                 )#fluidRow
               ),#tabPanel
               tabPanel(
                 h4(strong("Layer 2")),
                 br(),
                 fluidRow(
                   column(width=3,
                          uiOutput("geom_layer2")
                   ),
                   column(width=9,
                          uiOutput("prop2")
                   )#column
                 )#fluidRow
               ),
               tabPanel(
                 h4(strong("Layer 3")),
                 br(),
                 fluidRow(
                   column(width=3,
                          uiOutput("geom_layer3")
                   ),
                   column(width=9,
                          uiOutput("prop3")
                   )#column
                 )#fluidRow
               )
             )#tabsetPanel
          ),
          column(width=8,align="center",
                  tabsetPanel(
                    tabPanel(h4(strong("Display all")),
                    wellPanel(
                      br(),plotOutput("plot",height="100%", width="100%")
                    )
                    ),
                    tabPanel(h4(strong("Layer 1 only")),
                             wellPanel(
                               br(),plotOutput("layer1",height="100%", width="100%")
                             )
                    ),
                    tabPanel(h4(strong("Layer 2 only")),
                             wellPanel(
                               br(),plotOutput("layer2",height="100%", width="100%")
                             )
                    ),
                    tabPanel(h4(strong("Layer 3 only")),
                             wellPanel(
                               br(),plotOutput("layer3",height="100%", width="100%")
                             )
                    )
                    
                  )
           )#column
         )# fluidRow
)