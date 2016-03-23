tabPanel(title=h2(strong("Info")),
         fluidRow(
            column(width=4,offset=1,
                   br(),br(),br(),
                   imageOutput("mylogo")
            ),
            column(width=7,
                   br(),br(),
                   h2("The Graphics ToolKat V.1",
                        style="font-family: 'Lobster', cursive;
                        font-weight: 500; line-height: 1.8;
                        color: #4d3a7d;"),
                   h4("L. Vaudor, ISIG, UMR 5600"),
                   br(),
                   h5("A set of tools for producing simple, beautiful graphics"),
                   br(),br(),br(),
                   p("1) Upload your dataset"),
                   p("2) Choose your X and Y variables"),
                   p("3) Adjust parameters (size, color, graphic partitioning, etc.), possibly according to variable levels"),
                   p("4) Specify title, axis labels, size, etc."),
                   p("5) Download your graphic, in the format of your choice."),
                   br(),br(),
                   p("Information panels are signalled by:"),
                   imageOutput("catpaw1", width="100%",height="100%")
            )
          )#fluidRow
)#tabPanel
