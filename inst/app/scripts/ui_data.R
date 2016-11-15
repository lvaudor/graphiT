tabPanel(h2(strong("1) Data")),
         fluidRow(
           column(width=3,
                  h3(strong("a) Load data"))),
           column(width=1,
                  br(),
                  actionButton(inputId="infoLoad",
                               label=imageOutput("catpaw2",height="100%", width="100%")
                               )
           ),
           column(width=2,
                  fileInput('file', 'in CSV File')
           ),
           column(width=1,
                  checkboxInput(inputId="header",
                                label = "Header",
                                value=TRUE)
           ),
           column(width=1,
                  textInput(inputId="na.strings",
                            label = "Missing data",
                            value="NA")
           ),
           column(width=2,
                  selectInput(inputId="sep",
                              label = "Column separator",
                              choices =c(";",".","tab",","),
                              selected = ";")
           ),
           column(width=2,
                  selectInput(inputId="dec",
                              label = "Decimal separator",
                              choices =c(".",","),
                              selected = ".")
           )
         ),#fluidRow
         uiOutput("infoLoad"),
         fluidRow(
           column(width=3,
                  h3(strong("b) Subset data"))),
           column(width=1,
                  br(),
                  actionButton(inputId="infoSubset",
                               label=imageOutput("catpaw3",height="100%", width="100%")
                               )
           ),
           column(width=3,
                  selectInput("subsetvar","subset based on variable:",
                              choices=c("none",colnames(data)),
                              selected="none")
           ),#column
           column(width=3,
                  selectInput("subsetlev","subset individuals with value",
                              choices=c(""),
                              selected=c(""))
           )#column
         ),
         uiOutput("infoSubset"),
         br(),
         wellPanel(tableOutput("dataTable"),align="center")
)#tabPanel
