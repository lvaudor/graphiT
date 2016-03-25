tabPanel(h2(strong("3) Export")),
         fluidRow(
         column(width=3,
                h3(strong("a) Name and format"))),
         column(width=2,
                textInput(inputId="graph_filename",
                          label="file name",
                          value="plot")
         ),#column
         column(width=2,
                selectInput(inputId="graph_format",
                            label="format",
                            choices=c("png","jpeg","bmp","tiff"),
                            selected="png")
         )
       ),#fluidRow
       fluidRow(
         column(width=3,
                h3(strong("b) Choose size"))),
         column(width=2,
                sliderInput(inputId="exportheight",
                     label="height",
                     min=200,step=100,
                     max=1200,value=500)),
         column(width=2,
                sliderInput(inputId="exportwidth",
                     label="width",
                     min=200,step=100,
                     max=1600,value=800)
                )
       ),
       fluidRow(
          column(width=3,
                 h3(strong("c) Save file"))
          ),
          column(width=2,
              br(),
              downloadButton(outputId="dl_fig",label="Save")
          )
       ),#fluidRow
      wellPanel(plotOutput("plotexport",height="100%",width="100%"),
                align="center")
)#tabPanel