navlistPanel(
  tabPanel("Info",
           br()
  ),
  tabPanel(
    "Color",
    radioButtons(inputId="typecolor2",
                 label="Type",
                 choices=c("set","map"),
                 selected="set"),
    conditionalPanel(
      condition="input.typecolor2=='map'",
      selectInput(inputId="mapcolor2",
                  label="Map color to",
                  choices=c("none"),
                  selected="none")
    ),
    conditionalPanel(
      condition="input.typecolor2=='set'",
      selectInput(inputId="setcolor2",
                  label="Set color to",
                  choices=c("black","white","red","blue","green","orange"),
                  selected="black")
    )
  ),
  tabPanel(
    "Size",
    radioButtons(inputId="typesize2",
                 label="Type",
                 choices=c("set","map"),
                 selected="set"),
    conditionalPanel(
      condition="input.typesize2=='map'",
      selectInput(inputId="mapsize2",
                  label="Map size to",
                  choices=c("none"),
                  selected="none")
    ),
    conditionalPanel(
      condition="input.typesize2=='set'",
      selectInput(inputId="setsize2",
                  label="Set size to",
                  choices=c(1:5),
                  selected=1)
    )
  ),
  tabPanel(
    "Shape",
    radioButtons(inputId="typeshape2",
                 label="Type",
                 choices=c("set","map"),
                 selected="set"),
    conditionalPanel(
      condition="input.typeshape2=='map'",
      selectInput(inputId="mapshape2",
                  label="Map shape to",
                  choices=c("none"),
                  selected="none")
    ),
    conditionalPanel(
      condition="input.typeshape2=='set'",
      selectInput(inputId="setshape2",
                  label="Set shape to",
                  choices=c(0:25,"*","."),
                  selected="1")#,
      #imageOutput("symbol_shapes")
    )
  ),
  tabPanel(
    "Fill",
    radioButtons(inputId="typefill2",
                 label="Type",
                 choices=c("set","map"),
                 selected="set"),
    conditionalPanel(
      condition="input.typefill2=='map'",
      selectInput(inputId="mapfill2",
                  label="Map fill to",
                  choices=c("none"),
                  selected="none")
    ),
    conditionalPanel(
      condition="input.typefill2=='set'",
      selectInput(inputId="setfill2",
                  label="Set fill to",
                  choices=c("dark grey","black","white","red","green","yellow","blue"),
                  selected="dark grey")
    )
  ),
  tabPanel(
    "Line type",
    radioButtons(inputId="typelinetype2",
                 label="Type",
                 choices=c("set","map"),
                 selected="set"),
    conditionalPanel(
      condition="input.typelinetype2=='map'",
      selectInput(inputId="maplinetype2",
                  label="Map linetype to",
                  choices=c("none"),
                  selected="none")
    ),
    conditionalPanel(
      condition="input.typelinetype2=='set'",
      selectInput(inputId="setlinetype2",
                  label="Set linetype to",
                  choices=c(1:5),
                  selected=1)
    )
  ),  # tabPanel Line type
  tabPanel(
    "Position",
    radioButtons(inputId="position2",
                 label="positioning",
                 choices=c("stack","dodge","fill"),
                 selected="stack")
  ),# tabPanel Position
  tabPanel(
    "y",
    radioButtons(inputId="y2",
                 label="y",
                 choices=c("ignore","(..count..)/sum(..count..)"),
                 selected="ignore")
  )# tabPanel stat
)  #navlistPanel