tabPanel(title=h2(strong("Info")),
         fluidRow(
            column(width=4,offset=1,
                   br(),br(),br(),
                   imageOutput("mylogo")
            ),
            column(width=7,
                   br(),br(),
                   includeHTML(findmypath("scripts", "infoPresentation.html")),
                   imageOutput("catpaw1", width="100%",height="100%")
            )
          )#fluidRow
)#tabPanel
