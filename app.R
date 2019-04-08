library(shiny)
library(shinyWidgets)
library(melodyExtracter)

ui <- fluidPage(

  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "https://bootswatch.com/4/cerulean/bootstrap.css")),

  setBackgroundImage(src = "https://yese69.com/wp-content/uploads/data/2018/1/3/cool-music-background-wallpapers-1920x1200-for-computer-WTG3033827.jpg"),

  h1("This is a shiny webpage to get rid of the vocal of a song"),
  p("Please upload the wav file you want to remove the melody"),

  # App title ----
  titlePanel("Uploading wav Files"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput(
        inputId = "song",
        label = "Choose WAV File",
        multiple = FALSE,
        accept = c(".wav")
      ), # end of input wav

      checkboxInput(
        inputId = "compensate",
        label = "Add low freq compensate",
        value = FALSE
      ) , # end compensate part

      sliderInput(
        inputId = "keyChange",
        abel = "semitones you want to change"),
        value = 0,
        min = -12,
        max = 12
    ) # end keychange part

    ), # end sidebarPanel

    # Main panel for downloading outputs ----
    mainPanel(
      # Output: Data file ----
      downloadLink('downloadData', 'Download')
    )

)# end of ui

  # Define server logic to read selected file ----
  server <- function(input, output, session) {

      req(input$song)
      req(input$compensate)
      req(input$keyChange)

          output$downloadData <- downloadHandler(
            filename = function(){
              paste(Sys.Date(), '.wav', sep='')
            },
            content = function(con) {
              melodyExtractor(
            songLoadPath = input$song,
            songSavePath = input$download,
            compensate = input$compensate,
            keyChange = input$keyChange
            )
          }
        )# end of download part




  } # end of ui


shinyApp(ui, server)
